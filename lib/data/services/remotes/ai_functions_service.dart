import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:hontudy/data/prompt_builder.dart';

class AiFunctionsService {
  static const _timeout = Duration(seconds: 90);

  final FirebaseFunctions _functions;

  AiFunctionsService(this._functions);

  HttpsCallable _callable(String name) => _functions.httpsCallable(
    name,
    options: HttpsCallableOptions(timeout: _timeout),
  );

  /// LLM 응답 본문(JSON 문자열)을 Map으로 파싱해 반환
  Future<Map<String, dynamic>> sendPrompt({
    required List<Map<String, String>> messages,
    required double temperature,
  }) async {
    final result = await _callable('chatCompletion').call<Map<String, dynamic>>(
      {'messages': messages, 'temperature': temperature},
    );
    final content = result.data['content'] as String;
    return jsonDecode(content) as Map<String, dynamic>;
  }

  /// 녹음 파일을 Whisper로
  Future<String> transcribeAudio({
    required String filePath,
    List<String>? csTermHints,
  }) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final result = await _callable('transcribeAudio').call<Map<String, dynamic>>(
      {
        'audioBase64': base64Encode(bytes),
        'fileName': file.uri.pathSegments.last,
        'prompt': PromptBuilder.buildSttPrompt(csTermHints ?? []),
      },
    );
    return result.data['text'] as String;
  }

  /// 이미지를 생성해 Cloud Storage에 올린 뒤 다운로드 URL을 돌려준다.
  Future<String> generateImage({required String prompt}) async {
    final result = await _callable('generateImage').call<Map<String, dynamic>>(
      {'prompt': prompt},
    );
    return result.data['url'] as String;
  }
}
