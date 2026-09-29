import 'package:dio/dio.dart';
import 'package:hontudy/data/network/dio/dio_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'dio_client.g.dart';

@riverpod
Dio openaiDio(Ref ref) {
  final openaiApiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openaiApiKey',
      },
    ),
  );

  dio.interceptors.add(RetryInterceptor(dio));
  dio.interceptors.add(DioInterceptor());

  return dio;
}

@riverpod
Dio geminiDio(Ref ref) {
  final geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://generativelanguage.googleapis.com/v1beta',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': geminiApiKey,
      },
    ),
  );
  dio.interceptors.add(RetryInterceptor(dio));
  dio.interceptors.add(DioInterceptor());
  return dio;
}
