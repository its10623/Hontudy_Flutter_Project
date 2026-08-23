# AGENTS.md

AI 코딩 에이전트용 오리엔테이션. 상세 근거는 원본 문서 참고:
- PRD: `/Users/sm/Documents/Obsidian Vault/SeSAC Flutter/프로젝트/혼터디 v1.3.md`
- 아키텍처: `/Users/sm/Documents/Obsidian Vault/SeSAC Flutter/프로젝트/혼터디 아키텍처.md`
- 프롬프트 설계서: `/Users/sm/Documents/Obsidian Vault/SeSAC Flutter/프로젝트/혼터디 프롬프트 설계서.md`

## 개요
AI와의 멀티턴 대화로 사용자 IT 지식 수준을 진단하고, 개인화된 문제를 출제해 풀며 성장하는 학습 앱. 성장 시각화는 GitHub 히트맵 스타일("잔디심기").

## 기술 스택
- 아키텍처: MVVM + Clean Architecture (presentation/domain/data 물리적 분리)
- 상태관리/DI: Riverpod (`AsyncNotifier`), 별도 DI 도구 없음
- 에러 처리: `result_dart` (`Success`/`Failure`, `Ok`/`Error` 커스텀 타입 만들지 말 것)
- 네트워크: `dio` — 공식 Gemini SDK 대신 REST 직접 호출(세밀한 파라미터 제어 목적)
- 불변 모델: `freezed` + `json_serializable` (예정)
- 동적 UI: `package:genui` (알파)
- LLM: 진단=Gemini 2.5 Pro(유료), 문제출제/피드백=Gemini 3.5 Flash Lite. 모델 ID 하드코딩 금지
- 인증/DB: Firebase Auth + Firestore(영속) + SharedPreference(기기 로컬 설정만)
- 예정 패키지(pubspec 미추가): flutter_math_fork, speech_to_text, flutter_heatmap_calendar, shimmer, go_router

## 아키텍처 원칙
- View: 렌더링 + 상태 구독만, 비즈니스 로직 금지
- ViewModel: UseCase 호출, `AsyncNotifier.state`로 State 관리
- UseCase: `domain/repositories` 인터페이스에만 의존
- Repository 구현체: Service 결과를 Dto→Mapper→Model 변환, SSOT 유지
- Service: 외부 시스템 wrapper, 상태 없음, 데이터 소스당 1개
- Command 패턴 미사용 — `AsyncValue`가 대체
- UDF: View→ViewModel→UseCase→Repository로 이벤트, 상태는 역방향

## 폴더 구조 (목표, 아직 미적용)
```
lib/
├── presentation/{core,viewModels,ui/{pages,components}}
├── domain/{usecases,repositories,models}
├── data/{repositoriesImpl,services/{remotes,local},network,dto}
```
domain/data는 레이어별 조직, presentation/ui는 기능별(page/quiz/ 등) 조직.

## 도메인 모델
- **User**: uid/email/displayName/photoUrl/authProvider
- **DiagnosisProfile**: 배경(비전공자/전공자,단일) × 난이도스코어(1~5) × 목적태그(다중). 최종 결과값만 저장, 대화 과정은 미포함. "기억하기" 체크 시만 Firestore 저장
- **Quiz**: 문제 정의(카테고리 3단계/난이도/텍스트/정답/widget_type)
- **SolvedRecord**: 실제 풀이 기록(문제+답+정답여부+피드백+timestamp). **Quiz와 별도 엔티티.** 완료된 풀이만 저장, 기억하기와 무관하게 항상 저장(7일 재출제 방지·노트 화면 소스)
- **Chat**(UI 상태 전용): 채팅 메시지 목록, **Firestore 저장 안 함**, 화면 이탈/문제 전환 시 소멸

## LLM 출력 검증 (Mapper 단계에서 필수)
| 필드 | 규칙 |
| --- | --- |
| `next_action` | continue_diagnosis / ready_to_classify / user_requested_problem |
| `background` | 비전공자 / 전공자 |
| `difficulty_score` | 1~5 정수 |
| `purpose_tags` | 화이트리스트 배열, "입문 학습" 포함 시 difficulty_score는 1~2 |
| `widget_type`(진단) | free_text_input/choice_chips/single_choice_list/scale_rating/confirm_dialog/summary_confirm |
| `widget_type`(문제풀이) | code_block/image_diagram/math_formula/multiple_choice_question/short_answer_input/answer_feedback |
| `is_exhausted` | true면 복습모드 폴백, 문제로 저장 안 함 |

화이트리스트 벗어나면 저장/렌더링 거부. 사용자 자유 텍스트는 `<user_response>` 태그로 캡슐화해 프롬프트에 삽입.

## UI/프롬프트 규칙
- 진단·문제풀이 화면은 채팅 누적형 공유 (진단=세션당 1회 리셋, 문제풀이=문제 단위 리셋)
- 완료된 위젯은 접어서 비활성화, 하단 입력창은 항상 활성
- `code_block`은 `{"language":..., "code":...}` + 수평 스크롤 필수
- STT 결과는 즉시 제출 금지, 입력창에 채워 확인/수정 후 제출
- 문제출제 temperature 0.0~0.2, 최근 7일 내 최대 10개만 제외 키워드로 전달
- 바텀내비는 진단 대화 중 숨김, 문제풀이/노트/마이부터 노출

## 에러 처리
Service에서 예외를 `Failure(...)`로 감쌈 → Repository/UseCase는 `fold`로 처리 → ViewModel이 `AsyncError`로 흡수 → View는 `state.when(..., error:)`로 재시도 UI.

## 보안
- "기억하기" 미체크여도 대화는 Gemini API로 전송은 됨(저장만 안 함) — UI 문구 주의
- 화면 이탈 시 Chat 메모리 상태 확실히 비울 것
- API 로깅 시 개인정보 필드 마스킹 (dio 인터셉터)

## MVP 범위
1단계(구현 대상): 로그인/AI진단/문제풀이/노트/마이
2단계(아직 X): 대시보드, 랭킹, 카테고리 확장, 피드백 시스템 — 먼저 손대지 말 것

## 현재 상태
`flutter create` 직후 스캘폴드 상태(2026-08-23). pubspec엔 기본 패키지만 있음, 위 스택 나머지는 기능 구현 시 추가. lib/ 폴더도 목표 구조 미적용.

## 명령어
```bash
flutter pub get
flutter analyze
flutter test
flutter run
dart run build_runner build --delete-conflicting-outputs
```
