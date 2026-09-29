import 'package:dio/dio.dart';

const defaultGeminiImageModel = String.fromEnvironment(
  'GEMINI_IMAGE_MODEL',
  defaultValue: 'gemini-3.1-flash-lite-image',
);

class GeminiImageService {
  final Dio _dio;

  GeminiImageService(this._dio);

  Future<String> generateImage({
    required String model,
    required String prompt,
  }) async {
    final response = await _dio.post(
      '/models/$model:generateContent',
      data: {
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
        'generationConfig': {
          'responseModalities': ['TEXT', 'IMAGE'],
        },
      },
    );

    final parts = response.data['candidates'][0]['content']['parts'] as List;
    final imagePart = parts.firstWhere(
      (part) => part['inlineData'] != null,
      orElse: () => throw Exception('Gemini 응답에서 이미지 데이터를 찾을 수 없습니다'),
    );

    final mimeType = imagePart['inlineData']['mimeType'] as String;
    final base64Data = imagePart['inlineData']['data'] as String;

    return 'data:$mimeType;base64,$base64Data';
  }
}
