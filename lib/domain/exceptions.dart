
class QuizDomainExhaustedException implements Exception {
  @override
  String toString() => 'QuizDomainExhaustedException: 해당 서브주제 출제 가능 개념 고갈';
}

class DiagnosisProfileEmptyException implements Exception {
  @override
  String toString() => 'DiagnosisProfileEmptyException: 진단 프로필 기록 없어서 문제 출제 불가';
}