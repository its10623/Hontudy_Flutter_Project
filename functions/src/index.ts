/**
 * 혼터디 AI 프록시 (1단계)
 *
 * 앱에 OpenAI/Gemini 키를 두지 않기 위해 키를 Secret Manager에 두고 이 함수들이 대신 호출한다.
 * 프롬프트는 아직 앱(PromptBuilder)이 만들어 보낸다 — 2단계에서 기능별 함수로 서버 이전 예정.
 *
 * 공통 가드: 로그인 필수, App Check 강제, 사용자별 하루 호출 한도, 입력 크기 제한.
 */
import {randomUUID} from "node:crypto";

import {initializeApp} from "firebase-admin/app";
import {FieldValue, getFirestore} from "firebase-admin/firestore";
import {getDownloadURL, getStorage} from "firebase-admin/storage";
import {logger} from "firebase-functions";
import {
  defineBoolean,
  defineInt,
  defineSecret,
  defineString,
} from "firebase-functions/params";
import {
  CallableRequest,
  HttpsError,
  onCall,
} from "firebase-functions/v2/https";

initializeApp();

const openaiApiKey = defineSecret("OPENAI_API_KEY");
const geminiApiKey = defineSecret("GEMINI_API_KEY");

const openaiModel = defineString("OPENAI_MODEL", {default: "gpt-5.6-luna"});
const whisperModel = defineString("WHISPER_MODEL", {default: "whisper-1"});
const geminiImageModel = defineString("GEMINI_IMAGE_MODEL", {
  default: "gemini-3.1-flash-lite-image",
});
const dailyRequestLimit = defineInt("DAILY_REQUEST_LIMIT", {default: 200});
const maxCompletionTokens = defineInt("MAX_COMPLETION_TOKENS", {
  default: 4000,
});
// 에뮬레이터·초기 테스트에서만 false로 내린다. 배포 기본값은 true.
const enforceAppCheck = defineBoolean("ENFORCE_APP_CHECK", {default: true});

const REGION = "us-central1";
const OPENAI_BASE_URL = "https://api.openai.com/v1";
const GEMINI_BASE_URL = "https://generativelanguage.googleapis.com/v1beta";

const MAX_MESSAGES = 20;
const MAX_TOTAL_CONTENT_CHARS = 60_000;
const MAX_AUDIO_BYTES = 8 * 1024 * 1024;
const MAX_IMAGE_PROMPT_CHARS = 2_000;
const MAX_STT_PROMPT_CHARS = 1_000;
const ALLOWED_ROLES = new Set(["system", "user", "assistant"]);
const RETRYABLE_STATUS = new Set([500, 503]);
const MAX_RETRIES = 2;

const commonOptions = {
  region: REGION,
  enforceAppCheck: enforceAppCheck,
  timeoutSeconds: 120,
  memory: "512MiB" as const,
};

// ── 공통 가드 ──────────────────────────────────────────────

function requireUid(request: CallableRequest<unknown>): string {
  const uid = request.auth?.uid;
  if (!uid) {
    throw new HttpsError("unauthenticated", "로그인이 필요합니다.");
  }
  return uid;
}

/** 서울 기준 날짜 (YYYY-MM-DD). 하루 한도가 한국 자정에 초기화되도록. */
function seoulDate(now = new Date()): string {
  return new Intl.DateTimeFormat("en-CA", {
    timeZone: "Asia/Seoul",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(now);
}

/** 사용자별 하루 호출 수를 트랜잭션으로 올리고, 한도를 넘으면 거절한다. */
async function consumeDailyQuota(uid: string): Promise<void> {
  const limit = dailyRequestLimit.value();
  const ref = getFirestore()
    .collection("aiUsage")
    .doc(`${uid}_${seoulDate()}`);

  await getFirestore().runTransaction(async (tx) => {
    const snapshot = await tx.get(ref);
    const count = (snapshot.get("count") as number | undefined) ?? 0;
    if (count >= limit) {
      throw new HttpsError(
        "resource-exhausted",
        "오늘 사용할 수 있는 AI 요청을 모두 사용했습니다.",
      );
    }
    tx.set(
      ref,
      {
        uid,
        date: seoulDate(),
        count: FieldValue.increment(1),
        updatedAt: FieldValue.serverTimestamp(),
      },
      {merge: true},
    );
  });
}

function invalidArgument(message: string): HttpsError {
  return new HttpsError("invalid-argument", message);
}

/** 외부 API 호출. 500/503은 서버에서 재시도하고, 실패는 HttpsError로 바꾼다. */
async function fetchUpstream(
  name: string,
  url: string,
  init: RequestInit,
): Promise<Response> {
  for (let attempt = 0; ; attempt++) {
    let response: Response;
    try {
      response = await fetch(url, init);
    } catch (error) {
      logger.warn(`${name} 네트워크 오류`, {attempt});
      if (attempt < MAX_RETRIES) continue;
      throw new HttpsError("unavailable", `${name} 서버에 연결하지 못했습니다.`);
    }

    if (response.ok) return response;

    if (RETRYABLE_STATUS.has(response.status) && attempt < MAX_RETRIES) {
      logger.warn(`${name} ${response.status}, 재시도`, {attempt});
      await new Promise((resolve) => setTimeout(resolve, 1000 * (attempt + 1)));
      continue;
    }

    // 응답 본문에는 사용자 입력이 섞일 수 있어 상태 코드만 남긴다.
    logger.error(`${name} 실패`, {status: response.status});
    if (response.status >= 500) {
      throw new HttpsError("unavailable", `${name} 서버 오류`);
    }
    throw new HttpsError("internal", `${name} 요청이 거절되었습니다.`);
  }
}

// ── chatCompletion ────────────────────────────────────────

interface ChatMessage {
  role: string;
  content: string;
}

function parseMessages(raw: unknown): ChatMessage[] {
  if (!Array.isArray(raw) || raw.length === 0) {
    throw invalidArgument("messages가 비어 있습니다.");
  }
  if (raw.length > MAX_MESSAGES) {
    throw invalidArgument(`messages는 최대 ${MAX_MESSAGES}개입니다.`);
  }
  let totalChars = 0;
  const messages = raw.map((item): ChatMessage => {
    const role = (item as {role?: unknown})?.role;
    const content = (item as {content?: unknown})?.content;
    if (typeof role !== "string" || !ALLOWED_ROLES.has(role)) {
      throw invalidArgument("허용되지 않은 role입니다.");
    }
    if (typeof content !== "string" || content.length === 0) {
      throw invalidArgument("content가 비어 있습니다.");
    }
    totalChars += content.length;
    return {role, content};
  });
  if (totalChars > MAX_TOTAL_CONTENT_CHARS) {
    throw invalidArgument("요청 내용이 너무 깁니다.");
  }
  return messages;
}

function parseTemperature(raw: unknown): number {
  if (typeof raw !== "number" || Number.isNaN(raw)) return 0.2;
  return Math.min(1, Math.max(0, raw));
}

export const chatCompletion = onCall(
  {...commonOptions, secrets: [openaiApiKey]},
  async (request) => {
    const uid = requireUid(request);
    const data = (request.data ?? {}) as Record<string, unknown>;
    const messages = parseMessages(data.messages);
    const temperature = parseTemperature(data.temperature);

    await consumeDailyQuota(uid);

    const response = await fetchUpstream(
      "OpenAI",
      `${OPENAI_BASE_URL}/chat/completions`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${openaiApiKey.value()}`,
        },
        body: JSON.stringify({
          // 모델은 클라이언트가 아니라 서버 파라미터로만 정한다.
          model: openaiModel.value(),
          messages,
          temperature,
          max_completion_tokens: maxCompletionTokens.value(),
        }),
      },
    );

    const json = (await response.json()) as {
      choices?: {message?: {content?: string}}[];
    };
    const content = json.choices?.[0]?.message?.content;
    if (typeof content !== "string") {
      throw new HttpsError("internal", "OpenAI 응답 형식이 올바르지 않습니다.");
    }
    return {content};
  },
);

// ── transcribeAudio ───────────────────────────────────────

export const transcribeAudio = onCall(
  {...commonOptions, secrets: [openaiApiKey]},
  async (request) => {
    const uid = requireUid(request);
    const data = (request.data ?? {}) as Record<string, unknown>;

    if (typeof data.audioBase64 !== "string" || data.audioBase64.length === 0) {
      throw invalidArgument("audioBase64가 비어 있습니다.");
    }
    const audio = Buffer.from(data.audioBase64, "base64");
    if (audio.length === 0 || audio.length > MAX_AUDIO_BYTES) {
      throw invalidArgument("오디오 파일 크기가 올바르지 않습니다.");
    }
    const fileName =
      typeof data.fileName === "string" && data.fileName.length > 0 ?
        data.fileName.slice(0, 100) :
        "audio.m4a";
    const prompt =
      typeof data.prompt === "string" ?
        data.prompt.slice(0, MAX_STT_PROMPT_CHARS) :
        "";

    await consumeDailyQuota(uid);

    const form = new FormData();
    form.append("file", new Blob([audio]), fileName);
    form.append("model", whisperModel.value());
    if (prompt.length > 0) form.append("prompt", prompt);

    const response = await fetchUpstream(
      "OpenAI STT",
      `${OPENAI_BASE_URL}/audio/transcriptions`,
      {
        method: "POST",
        headers: {Authorization: `Bearer ${openaiApiKey.value()}`},
        body: form,
      },
    );

    const json = (await response.json()) as {text?: string};
    if (typeof json.text !== "string") {
      throw new HttpsError("internal", "STT 응답 형식이 올바르지 않습니다.");
    }
    return {text: json.text};
  },
);

// ── generateImage ─────────────────────────────────────────

const IMAGE_EXTENSIONS: Record<string, string> = {
  "image/png": "png",
  "image/jpeg": "jpg",
  "image/webp": "webp",
};

export const generateImage = onCall(
  {...commonOptions, secrets: [geminiApiKey]},
  async (request) => {
    const uid = requireUid(request);
    const data = (request.data ?? {}) as Record<string, unknown>;
    const prompt = data.prompt;
    if (typeof prompt !== "string" || prompt.length === 0) {
      throw invalidArgument("prompt가 비어 있습니다.");
    }
    if (prompt.length > MAX_IMAGE_PROMPT_CHARS) {
      throw invalidArgument("prompt가 너무 깁니다.");
    }

    await consumeDailyQuota(uid);

    const response = await fetchUpstream(
      "Gemini",
      `${GEMINI_BASE_URL}/models/${geminiImageModel.value()}:generateContent`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-goog-api-key": geminiApiKey.value(),
        },
        body: JSON.stringify({
          contents: [{parts: [{text: prompt}]}],
          generationConfig: {responseModalities: ["TEXT", "IMAGE"]},
        }),
      },
    );

    const json = (await response.json()) as {
      candidates?: {
        content?: {parts?: {inlineData?: {mimeType?: string; data?: string}}[]};
      }[];
    };
    const inline = json.candidates?.[0]?.content?.parts
      ?.find((part) => part.inlineData?.data)?.inlineData;
    if (!inline?.data) {
      throw new HttpsError("internal", "Gemini 응답에 이미지가 없습니다.");
    }

    const mimeType = inline.mimeType ?? "image/png";
    const extension = IMAGE_EXTENSIONS[mimeType] ?? "png";
    // data: URI를 Firestore에 저장하면 문서 1MiB 한도를 넘을 수 있어 Storage에 올리고 URL만 돌려준다.
    const file = getStorage()
      .bucket()
      .file(`quizImages/${uid}/${randomUUID()}.${extension}`);
    await file.save(Buffer.from(inline.data, "base64"), {
      contentType: mimeType,
      resumable: false,
    });

    return {url: await getDownloadURL(file)};
  },
);
