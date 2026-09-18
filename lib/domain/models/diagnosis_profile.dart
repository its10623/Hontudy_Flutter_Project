import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_profile.freezed.dart';

@freezed
class DiagnosisProfile with _$DiagnosisProfile {
  final String background;//전공자
  final int difficultyScore;//2
  final List<String> purposeTags;//취업
  final List<String> weakAreas;//network, architecture, math

  const DiagnosisProfile({
    required this.background,
    required this.difficultyScore,
    required this.purposeTags,
    required this.weakAreas,
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
