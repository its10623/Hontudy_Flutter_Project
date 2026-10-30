#!/usr/bin/env bash
# 릴리스 전 점검: 버전, iOS 버전 캐시, 시크릿, 문의 이메일, 데이터 관련 변경, 이번 릴리스 커밋
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"

ok()   { echo "  [OK]   $*"; }
warn() { echo "  [WARN] $*"; }
fail() { echo "  [FAIL] $*"; FAILED=1; }
FAILED=0

current=$(sed -n 's/^version: *//p' pubspec.yaml)
cur_name=${current%+*}
cur_build=${current#*+}

prev_commit=""; prev_version=""
for c in $(git log --format=%h -G'^version:' -- pubspec.yaml); do
  v=$(git show "$c:pubspec.yaml" | sed -n 's/^version: *//p')
  if [ "$v" != "$current" ]; then prev_commit=$c; prev_version=$v; break; fi
done
prev_build=${prev_version#*+}

echo "== 버전"
echo "  현재 pubspec: $current / 이전 릴리스: ${prev_version:-없음} ($prev_commit)"
if [ -n "$prev_version" ] && [ "$cur_build" -le "$prev_build" ] 2>/dev/null; then
  fail "빌드 번호(+$cur_build)가 이전(+$prev_build)보다 커야 해요"
else
  ok "빌드 번호 증가"
fi
if git diff --quiet HEAD -- pubspec.yaml; then ok "pubspec 버전 커밋됨"; else warn "pubspec.yaml 변경이 커밋되지 않음"; fi

echo "== iOS 버전 캐시 (ios/Flutter/Generated.xcconfig)"
xc=ios/Flutter/Generated.xcconfig
if [ -f "$xc" ]; then
  xn=$(sed -n 's/^FLUTTER_BUILD_NAME=//p' "$xc"); xb=$(sed -n 's/^FLUTTER_BUILD_NUMBER=//p' "$xc")
  if [ "$xn" = "$cur_name" ] && [ "$xb" = "$cur_build" ]; then ok "$xn ($xb)"
  else warn "$xn ($xb) → Xcode에서 바로 Archive하면 이전 버전으로 올라가요. flutter build ipa로 갱신"; fi
else
  warn "파일 없음 (flutter build ipa 시 생성)"
fi

echo "== 작업 트리 / 시크릿"
tracked=$(git status --porcelain --untracked-files=no)
if [ -z "$tracked" ]; then ok "커밋 안 된 추적 파일 없음"; else warn "커밋 안 된 변경:"; echo "$tracked" | sed 's/^/         /'; fi
secrets=$(git ls-files | grep -E '(^|/)(key\.properties|\.env)$|\.(jks|keystore|p8)$')
if [ -z "$secrets" ]; then ok "추적 중인 시크릿 파일 없음"; else fail "시크릿 파일이 git에 있음:"; echo "$secrets" | sed 's/^/         /'; fi

echo "== 문의 이메일"
gm=$(grep -rn '@gmail\.com' lib/ 2>/dev/null)
if [ -z "$gm" ]; then ok "lib/에 gmail 주소 없음"; else warn "옛 이메일 남음:"; echo "$gm" | sed 's/^/         /'; fi

echo "== 디버그 전용 코드 (kDebugMode 가드 확인용)"
grep -rln 'kDebugMode' lib/ | sed 's/^/         /'

if [ -n "$prev_commit" ]; then
  echo "== 데이터 수집 관련 변경 ($prev_commit..HEAD) — 있으면 방침·Play 데이터 보안·App Store 라벨 검토"
  data=$(git diff --stat "$prev_commit"..HEAD -- lib/data/dto firestore.rules storage.rules functions/src lib/data/services 2>/dev/null)
  if [ -z "$data" ]; then ok "변경 없음"; else echo "$data" | sed 's/^/         /'; fi

  echo "== 이번 릴리스 커밋 ($prev_commit..HEAD)"
  git log --format='  %h %s' "$prev_commit"..HEAD
fi

exit $FAILED
