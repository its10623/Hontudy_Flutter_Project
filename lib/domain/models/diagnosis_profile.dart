import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_profile.freezed.dart';

@freezed
class DiagnosisProfile with _$DiagnosisProfile {
  final String background;
  final int difficultyScore;
  final List<String> purposeTags;
  final List<String> weakAreas;
  final DateTime timestamp;

  const DiagnosisProfile({
    required this.background,
    required this.difficultyScore,
    required this.purposeTags,
    required this.weakAreas,
    required this.timestamp   // 진단 프로필 덮어쓰기 -> 최신화 업데이트로 바꾸면서 기록들을 보관하기 위한 timeStamp 추가
  });
}

@freezed
class DiagnosisResult with _$DiagnosisResult {
  final DiagnosisProfile profile;
  final String? backgroundDetail;
  final String reasoning;
  final int confidence;
  //uid

  const DiagnosisResult({
    required this.profile,
    this.backgroundDetail,
    required this.reasoning,
    required this.confidence,
  });
}
