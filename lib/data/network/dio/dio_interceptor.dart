import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final Set<String> sensitiveKeys = {'authorization', 'content', 'x-goog-api-key'};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[REQUEST] ${options.method} => ${options.uri}');
    print('Headers: ${_maskMap(options.headers)}');
    if (options.data != null) {
      print('Body: ${_maskData(options.data)}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    print('[RESPONSE] ${response.statusCode} => ${response.data}');
    print('Data: ${_maskData(response.data)}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('[ERROR] ${err.response?.statusCode} => ${err.message}');
    if (err.response?.data != null) {
      print('Error Data: ${_maskData(err.response?.data)}');
    }
    return super.onError(err, handler);
  }

  dynamic _maskData(dynamic data) {
    if (data is Map) {
      return _maskMap(data);
    } else if (data is List) {
      return data.map((item) => _maskData(item)).toList();
    }
    return data;
  }

  Map<dynamic, dynamic> _maskMap(Map map) {
    final maskedMap = Map.from(map);
    maskedMap.forEach((key, value) {
      if (sensitiveKeys.contains(key.toString().toLowerCase())) {
        maskedMap[key] = '***MASKED***';
      } else if (value is Map || value is List) {
        maskedMap[key] = _maskData(value);
      }
    });
    return maskedMap;
  }
}

class RetryInterceptor extends Interceptor {
  static const _maxRetries = 3;

  final Dio dio;

  RetryInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isRetryableStatus =
        err.response?.statusCode == 500 || err.response?.statusCode == 503;
    final retryCount = (err.requestOptions.extra['retryCount'] as int?) ?? 0;

    if (isRetryableStatus && retryCount < _maxRetries) {
      print('서버 오류 발생, 3초 후 재시도... (${retryCount + 1}/$_maxRetries)');
      await Future.delayed(const Duration(seconds: 3));

      try {
        final response = await dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            extra: {
              ...err.requestOptions.extra,
              'retryCount': retryCount + 1,
            },
          ),
        );
        return handler.resolve(response);
      } on DioException catch (retryError) {
        return handler.next(retryError);
      }
    }

    return super.onError(err, handler);
  }
}
