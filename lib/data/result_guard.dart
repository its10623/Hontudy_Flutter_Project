import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:hontudy/domain/exceptions.dart';
import 'package:result_dart/result_dart.dart';

Future<ResultDart<S, Exception>> guardAsync<S extends Object>(
  Future<S> Function() action,
) async {
  try {
    return Success(await action());
  } on DomainException catch (e) {
    return Failure(e);
  } on DioException catch (e) {
    // 서버 응답 에러
    if (e.type == DioExceptionType.badResponse) {
      return Failure(ServerException(e));
    }

    // 연결 및 타임아웃 관련 네트워크 에러
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return Failure(NetworkException(e));
    }

    // 그 외 알 수 없는 에러
    return Failure(UnknownException(e));
  } on FirebaseException catch (e) {
    // 서비스 이용 불가 및 요청 시간 초과 네트워크 에러
    if (e.code == 'unavailable' || e.code == 'deadline-exceeded') {
      return Failure(NetworkException(e));
    }

    // 내부 서버 오류
    if (e.code == 'internal') {
      return Failure(ServerException(e));
    }

    if (e.code == 'network-request-failed') {
      return Failure(NetworkException(e));
    }

    return Failure(UnknownException(e));
  } catch (e) {
    return Failure(UnknownException(e));
  }
}
