import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hontudy/domain/exceptions.dart';
import 'package:result_dart/result_dart.dart';

/// Service가 던진 원본 예외를 domain 예외로 분류해 Failure로 감싼다.
///
/// AI 호출은 Cloud Functions(callable)를 거치는데, `FirebaseFunctionsException`도
/// `FirebaseException`을 상속하므로 아래 Firebase 분기에서 함께 처리된다.
Future<ResultDart<S, Exception>> guardAsync<S extends Object>(
  Future<S> Function() action,
) async {
  try {
    return Success(await action());
  } on DomainException catch (e) {
    return Failure(e);
  } on FirebaseException catch (e) {
    // 서버 함수의 사용자별 하루 한도 초과
    if (e.code == 'resource-exhausted') {
      return Failure(AiUsageLimitExceededException());
    }

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

    // unauthenticated / permission-denied(App Check 실패 포함) 등
    return Failure(UnknownException(e));
  } catch (e) {
    return Failure(UnknownException(e));
  }
}
