import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hontudy/data/network/dio/dio_client.dart';
import 'package:hontudy/data/prompt_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'llm_service.g.dart';

class LlmService {
  final Dio _dio;

  LlmService(this._dio);

  Future<Map<String, dynamic>> sendPrompt({
    required String model,
    required List<Map<String, String>> messages,
    required double temperature,
  }) async {
    final response = await _dio.post(
      '/chat/completions',
      data: {'model': model, 'messages': messages, 'temperature': temperature},
    );
    final String aiAnswer = response.data['choices'][0]['message']['content'];

    final parsed = jsonDecode(aiAnswer) as Map<String, dynamic>;
    return parsed;
  }

  // wisper-1 STT
  Future<String> transcribeAudio({
    required String model,
    required String filePath,
    List<String>? csTermHints,
  }) async {
    final sttPrompt = PromptBuilder.buildSttPrompt(csTermHints ?? []);
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'model': model,
      if (sttPrompt.isNotEmpty) 'prompt': sttPrompt,
    });

    final response = await _dio.post(
      '/audio/transcriptions',
      data: formData,
    );

    final String transcribedText = response.data['text'];
    return transcribedText;
  }
}

@riverpod
LlmService llmService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return LlmService(dio);
}
