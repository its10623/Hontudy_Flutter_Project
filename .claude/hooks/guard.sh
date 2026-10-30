#!/usr/bin/env bash
# PreToolUse: 되돌리기 어려운 git 명령과 시크릿 파일 접근을 막는다 (exit 2 = 차단, stderr가 Claude에게 전달)
input=$(cat)
tool=$(jq -r '.tool_name // empty' <<<"$input")

secret='(^|[/[:space:]"'\''])(key\.md|key\.properties|\.env)([[:space:]"'\'']|$)|\.(p8|jks|keystore)([[:space:]"'\'']|$)'

block() { echo "훅 차단: $1" >&2; exit 2; }

case "$tool" in
  Bash)
    cmd=$(jq -r '.tool_input.command // empty' <<<"$input")
    grep -Eq '(^|[;&|[:space:]])git[[:space:]]+push' <<<"$cmd" && block "git push는 사용자가 직접 요청할 때만, 사용자가 실행하세요"
    grep -Eq 'git[[:space:]]+commit.*--amend' <<<"$cmd" && block "--amend 금지 — 새 커밋을 만드세요"
    grep -Eq -- '--no-verify' <<<"$cmd" && block "--no-verify 금지 — 훅 실패 원인을 고치세요"
    grep -Eq 'git[[:space:]]+reset[[:space:]]+--hard' <<<"$cmd" && block "reset --hard 금지"
    grep -Eq 'git[[:space:]]+add[[:space:]]+(-A|--all|\.)([[:space:]]|$)' <<<"$cmd" && block "git add -A/. 금지 — 파일을 명시해서 스테이징하세요"
    if grep -Eq "$secret" <<<"$cmd"; then
      grep -Eq '(^|[;&|[:space:]])(git[[:space:]]+add|cat|less|more|head|tail|cp|mv|open|base64|xxd|strings|sed|awk)[[:space:]]' <<<"$cmd" \
        && block "시크릿 파일(key.md, key.properties, .env, *.p8, *.jks, *.keystore)은 읽거나 스테이징하지 않아요"
    fi
    ;;
  Read|Edit|Write)
    path=$(jq -r '.tool_input.file_path // empty' <<<"$input")
    grep -Eq "$secret" <<<"$path" && block "시크릿 파일($path)은 열지 않아요"
    ;;
esac
exit 0
