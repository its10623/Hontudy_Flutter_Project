/// 프롬프트로 평문을 요구해도 LLM이 가끔 섞어 보내는 마크다운,LaTeX 기호를 걷어낸다
String llmPlainText(String raw) {
  return raw
      .replaceAll(r'\n', '\n')
      .replaceAll(RegExp(r'\\[()\[\]]'), '')
      .replaceAllMapped(RegExp(r'\^\{([^{}]*)\}'), (m) => '^${m[1]}')
      .replaceAll('**', '')
      .replaceAll('`', '')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();
}

String? llmPlainTextOrNull(String? raw) =>
    raw == null ? null : llmPlainText(raw);
