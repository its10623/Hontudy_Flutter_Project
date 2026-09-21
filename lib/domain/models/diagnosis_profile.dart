import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_profile.freezed.dart';

@freezed
class DiagnosisProfile with _$DiagnosisProfile {
  final String background;
  final int difficultyScore;
  final List<String> purposeTags;

  const DiagnosisProfile({
    required this.background,
    required this.difficultyScore,
    required this.purposeTags,
  });
}

@freezed
class DiagnosisResult with _$DiagnosisResult {
  final DiagnosisProfile profile;
  final String? backgroundDetail;
  final List<String> weakAreas;
  final String reasoning;
  final int confidence;
  //uid

  const DiagnosisResult({
    required this.profile,
    this.backgroundDetail,
    required this.weakAreas,
    required this.reasoning,
    required this.confidence,
  });
}
