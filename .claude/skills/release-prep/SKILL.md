---
name: release-prep
description: 혼터디 Android·iOS 스토어 릴리스 준비 — 버전 올리기, 릴리스 전 점검 스크립트 실행, iOS Generated.xcconfig 버전 캐시 확인, AAB·IPA 빌드, git log 기반 업데이트 문구(App Store "새로운 기능"·Play 출시 노트) 작성, 데이터 수집 변경 시 개인정보처리방침·Play 데이터 보안·App Store 개인정보 라벨 점검까지 수행. "릴리스 준비", "배포 준비", "스토어 올리기", "버전 올려줘", "업뎃 멘트", "출시 노트", "빌드 번호", "심사 제출 전 점검", "1.0.x 배포" 같은 요청이면 반드시 이 스킬을 사용할 것. 웹(hontudy.com) 배포는 web-deploy 스킬을 쓴다.
---

# 릴리스 준비 (Android · iOS)

스토어 업로드 직전까지를 한 흐름으로 처리한다. 업로드·콘솔 설정·폼 제출은 사용자가 하고, 에이전트는 점검·빌드·문구 작성·체크리스트 안내까지만 한다. 서명·키·Firebase SHA·App Check처럼 처음 한 번 세팅하는 절차와 알려진 함정은 루트의 `앱 배포 에이전트.md`에 있으니, 빌드가 서명·App Check 관련으로 실패하면 그 문서의 해당 절을 읽는다.

## 1. 버전 결정
- `pubspec.yaml`의 `version: X.Y.Z+N`을 확인한다. 스토어는 같은 빌드 번호를 다시 받지 않으므로 `+N`은 업로드마다 반드시 올린다.
- 버전 이름은 semver: 버그 수정·작은 기능 → patch(1.0.x), UI/UX 구조 변경 → minor(1.x.0). 애매하면 사용자에게 묻는다.
- 버전 수정은 에이전트가 해도 된다. 커밋은 사용자가 요청할 때만 `/commit` 규칙으로 한다.

## 2. 점검 스크립트
```bash
.claude/skills/release-prep/scripts/preflight.sh
```
출력 항목별 판단:
- **[FAIL] 빌드 번호 / 시크릿 파일**: 빌드로 넘어가지 말고 먼저 해결한다. 시크릿 값은 절대 출력하지 않는다.
- **iOS 버전 캐시 [WARN]**: `Info.plist`는 `$(FLUTTER_BUILD_NAME)`을 쓰고 실제 값은 `Generated.xcconfig`에 있다. 이 파일은 flutter 명령을 실행해야 갱신되므로, Xcode에서 바로 Archive하면 이전 버전이 올라간다. 반드시 `flutter build ipa`로 빌드하거나 최소 `flutter pub get` 후 Archive하라고 안내한다.
- **커밋 안 된 변경**: 릴리스에 들어갈 변경인지 사용자에게 확인한다. Xcode가 `Info.plist` 키 순서만 바꾼 경우처럼 의미 없는 변경은 그렇다고 알려준다.
- **문의 이메일**: 옛 주소(gmail)가 남아 있으면 앱·방침·스토어 문의처가 어긋난다.
- **데이터 수집 관련 변경**: 4단계로 이어진다.

이어서 `flutter analyze`를 실행해 error가 0인지 확인한다(warning/info는 보고만).

## 3. 빌드
```bash
flutter build appbundle --release   # build/app/outputs/bundle/release/app-release.aab
flutter build ipa --release         # build/ios/archive/Runner.xcarchive, build/ios/ipa/*.ipa
```
- 빌드는 오래 걸리므로 백그라운드로 실행하고 끝나면 결과 경로와 버전을 보고한다.
- `flutter build ipa` 뒤 `Generated.xcconfig`가 새 버전인지 다시 확인한다. Xcode Organizer의 이전 버전 아카이브는 업로드하지 말라고 안내한다.
- 실패하면 에러 원문을 그대로 보고하고, 서명·프로비저닝 문제면 `앱 배포 에이전트.md` 5-1, App Check·SHA 문제면 4-4·4-5를 참고한다.

## 4. 데이터 수집 변경 점검
점검 스크립트에서 `lib/data/dto`, `firestore.rules`, `lib/data/services`, `functions/src`가 바뀌었으면, diff를 읽고 **새로 저장·전송하는 필드**가 있는지 판단한다. 리팩토링(파일 이동·이름 변경)은 해당 없음.

새 필드가 있으면 세 곳을 같은 기준으로 맞추도록 안내한다. 기준은 "애매하면 보수적으로 신고"(2026-10-07 결정).
| 위치 | 확인할 것 |
|---|---|
| 노션 개인정보처리방침 | 수집 항목, 보관 기간, 위탁 업체, 시행일, 문의 이메일 |
| Play 데이터 보안 | 데이터 유형, 수집/공유(위탁 처리는 공유 아님), 일시적 처리 여부, 필수/선택, 목적. 게시 개요에서 빌드와 함께 검토 전송 |
| App Store 개인정보 라벨 | 데이터 유형, 사용자 연결 여부, 추적 여부, 목적. **게시 즉시 반영**되므로 심사 제출 시점에 게시 |

스토어 양식은 모바일 앱 기준이라 웹 전용 데이터(reCAPTCHA 등)는 넣지 않는다. 법률 자문이 아니라는 점을 함께 밝힌다.

## 5. 업데이트 문구
점검 스크립트의 "이번 릴리스 커밋" 목록에서 **사용자가 체감하는 변경만** 고른다.
- 뺄 것: `refactor`/`build`/`chore`/`docs`, 웹 전용 변경, 내부 구조 변경, 사용자에게 알릴 필요 없는 설정
- 묶을 것: 같은 기능의 여러 커밋(Dto·Repository·ViewModel·View)은 한 줄로
- 말투: 해요체, 기능 이름보다 사용자가 할 수 있게 된 일 중심. 심사관이 새 기능을 찾을 수 있도록 사용 방법(예: "길게 눌러 신고")을 짧게 붙인다
- 형식 두 가지를 함께 낸다:
  - App Store "이 버전의 새로운 기능": `•` 목록, 문장형
  - Google Play 출시 노트: `<ko-KR>` … `</ko-KR>` 태그, 500자 이내, 짧은 명사형
- Play "출시 이름"은 내부 이름이다. 기본값(빌드 번호와 버전)을 그대로 두라고 안내한다.

## 6. 사용자 체크리스트로 마무리
아래를 짧은 목록으로 보고한다.
1. 빌드 결과 경로와 버전
2. 업로드: Play Console 비공개 테스트(또는 프로덕션) 트랙 / Xcode Organizer 또는 Transporter
3. 4단계에서 나온 방침·양식 수정 항목
4. 업데이트 문구 (App Store / Play)
5. Obsidian `혼터디 할 일.md`의 배포 항목 중 완료된 것은 사용자 확인 후 `[x]`

## 권한 경계
- 에이전트: 버전 수정, 점검, `flutter build`, 문구 작성, 안내
- 사용자: 스토어 업로드, 콘솔 설정 변경, 폼 제출, 서명 인증서·키 작업
- 금지: 키·토큰·비밀번호 출력, `git push`, `--amend`, `--no-verify`, 커밋 메시지 attribution 줄
