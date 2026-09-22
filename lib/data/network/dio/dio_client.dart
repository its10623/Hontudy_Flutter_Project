
import 'package:dio/dio.dart';
import 'package:hontudy/data/network/dio/dio_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@riverpod
Dio dio(Ref ref) {
  const apiKey = String.fromEnvironment('OPENAI_API_KEY');
  final dio = Dio(
      BaseOptions(
          baseUrl: 'https://api.openai.com/v1',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey'
          }
      )
  );
  
  dio.interceptors.add(RetryInterceptor(dio));
  dio.interceptors.add(DioInterceptor());

  return dio;
}