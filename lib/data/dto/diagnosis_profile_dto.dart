import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';

part 'diagnosis_profile_dto.g.dart';

@JsonSerializable()
class DiagnosisProfileDto {
  final String background;
  final int difficultyScore;
  final List<String> purposeTags;
  final List<String> weakAreas;
  final DateTime timestamp;

  const DiagnosisProfileDto({
    required this.background,
    required this.difficultyScore,
    required this.purposeTags,
    required this.weakAreas,
    required this.timestamp,
  });

  factory DiagnosisProfileDto.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisProfileDtoToJson(this);
}

class DiagnosisProfileMapper {
  static DiagnosisProfile toDomain(DiagnosisProfileDto dto) {
    return DiagnosisProfile(
      background: dto.background,
      difficultyScore: dto.difficultyScore,
      purposeTags: dto.purposeTags,
      weakAreas: dto.weakAreas,
      timestamp: dto.timestamp,
    );
  }

  static DiagnosisProfileDto toDto(DiagnosisProfile model) {
    return DiagnosisProfileDto(
      background: model.background,
      difficultyScore: model.difficultyScore,
      purposeTags: model.purposeTags,
      weakAreas: model.weakAreas,
      timestamp: model.timestamp,
    );
  }
}
