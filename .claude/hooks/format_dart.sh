#!/usr/bin/env bash
# PostToolUse: Claude가 수정한 .dart 파일 하나만 포맷 (생성 파일 제외)
path=$(jq -r '.tool_input.file_path // empty')
case "$path" in
  *.g.dart|*.freezed.dart) exit 0 ;;
  *.dart) ;;
  *) exit 0 ;;
esac
[ -f "$path" ] || exit 0
dart_bin=$(command -v dart || echo /Users/sm/AndroidStudioProjects/flutter/bin/dart)
"$dart_bin" format "$path" >/dev/null 2>&1
exit 0
