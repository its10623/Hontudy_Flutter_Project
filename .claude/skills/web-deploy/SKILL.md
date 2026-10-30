---
name: web-deploy
description: 혼터디 웹(hontudy.com, Firebase Hosting) 빌드·배포 — flutter build web 후 firebase deploy --only hosting, 필요 시 Firestore 규칙 함께 배포, 배포 후 사이트 응답 확인과 웹 로그인·AI 호출 문제(승인된 도메인, reCAPTCHA 키 도메인, App Check) 진단까지 수행. "웹 배포", "웹 올려줘", "hosting 배포", "hontudy.com 반영", "웹 업데이트", "수정한 거 웹에도 반영" 같은 요청이면 반드시 이 스킬을 사용할 것. Android·iOS 스토어 배포는 release-prep 스킬을 쓴다.
---

# 웹 배포 (Firebase Hosting → hontudy.com)

`firebase.json`의 hosting은 `build/web`을 올리고 모든 경로를 `/index.html`로 보낸다(SPA). 프로젝트는 `.firebaserc`의 `hontudy`. 앱 코드를 고친 뒤 웹에도 반영하려면 매번 빌드와 배포를 다시 해야 한다.

## 1. 사전 확인
```bash
git status --short --untracked-files=no
```
- 커밋되지 않은 변경이 있으면 "이 상태 그대로 웹에 올라간다"고 알려주고 진행 여부를 확인한다. 배포 자체에 커밋이 필요하지는 않다.
- `firestore.rules`가 마지막 배포 이후 바뀌었는지 사용자에게 묻는다. 바뀌었으면 3단계에서 규칙도 같이 배포한다. 규칙만 앱보다 먼저 나가면 구버전 앱의 쓰기가 막힐 수 있으니 순서를 설명한다.

## 2. 빌드
```bash
flutter build web --release
```
- 릴리스 빌드는 `ReCaptchaEnterpriseProvider`를 쓰므로 `APP_CHECK_WEB_DEBUG_TOKEN` dart-define이 필요 없다. 디버그 토큰을 빌드 명령에 넣지 않는다.
- 결과는 `build/web/`. 실패하면 에러 원문을 보고한다.

## 3. 배포 (쓰기 작업 — 사용자 승인 후 실행)
배포는 공개 사이트를 바꾸는 작업이므로, 실행할 명령을 보여주고 승인을 받은 뒤 실행한다.
```bash
firebase deploy --only hosting
firebase deploy --only hosting,firestore:rules   # 규칙도 바뀐 경우
```
- Functions는 이 스킬 범위가 아니다(`--only functions`는 별도 요청일 때만).
- 출력의 Hosting URL과 완료 여부를 보고한다.

## 4. 배포 확인
```bash
curl -sI https://hontudy.com | head -1
curl -s https://hontudy.com | grep -o '<title>[^<]*</title>'
```
- 200과 `<title>혼터디</title>`이 나오면 정상이다.
- 브라우저에서 이전 화면이 보이면 강력 새로고침(⌘⇧R)을 안내한다.
- 실제 동작(로그인 → 진단 AI 응답)은 사용자가 브라우저에서 확인하도록 안내한다.

## 5. 웹에서만 생기는 문제
| 증상 | 원인 | 해결 (사용자 콘솔 작업) |
|---|---|---|
| 커스텀 도메인에서만 로그인 "알 수 없는 오류" | `auth/unauthorized-domain` | Firebase Auth → 설정 → 승인된 도메인에 `hontudy.com` 추가 |
| 로그인은 되는데 AI 호출이 실패 | App Check 토큰 발급 실패 | reCAPTCHA Enterprise 키의 도메인 목록에 `hontudy.com` 추가, App Check 지표에서 "확인되지 않은 요청" 확인 |
| 팝업을 닫은 뒤 10초쯤 로딩 | Firebase JS SDK의 COOP 관련 알려진 동작 | 버그 아님 |
| 팝업이 안 뜸 | 브라우저 팝업 차단 | 앱이 `WebPopupBlockedException` 안내를 띄움 |
| 로컬 `flutter run -d chrome`에서만 AI 호출 실패 | 실행마다 디버그 토큰이 바뀜 | `--dart-define=APP_CHECK_WEB_DEBUG_TOKEN=...` 고정 토큰 사용(값은 출력하지 않음) |

콘솔 에러 원문이 필요하면 사용자에게 브라우저 개발자 도구 Console의 `auth/...` 또는 `appCheck/...` 코드를 보내 달라고 한다.

## 권한 경계
- 에이전트: 상태 확인, `flutter build web`, 승인 후 `firebase deploy`, curl 확인
- 사용자: Firebase·Cloudflare·reCAPTCHA 콘솔 설정, 브라우저 동작 확인
- 금지: 디버그 토큰·키 출력, 승인 없는 배포, `git push`
