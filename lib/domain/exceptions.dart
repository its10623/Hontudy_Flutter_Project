abstract class DomainException implements Exception {}

class QuizDomainExhaustedException implements DomainException {
  @override
  String toString() => 'QuizDomainExhaustedException: 해당 서브주제 출제 가능 개념 고갈';
}

class DiagnosisProfileEmptyException implements DomainException {
  @override
  String toString() => 'DiagnosisProfileEmptyException: 진단 프로필 기록 없어서 문제 출제 불가';
}

class SignInCancelledException implements DomainException {
  @override
  String toString() => 'SignInCancelledException: 사용자가 소셜 로그인을 취소함';
}

class NetworkException implements Exception {
  final Object cause;

  NetworkException(this.cause);

  @override
  String toString() => 'NetworkException: $cause';
}

class ServerException implements Exception {
  final Object cause;

  ServerException(this.cause);

  @override
  String toString() => 'ServerException: $cause';
}

class UnknownException implements Exception {
  final Object cause;

  UnknownException(this.cause);

  @override
  String toString() => 'UnknownException: $cause';
}
