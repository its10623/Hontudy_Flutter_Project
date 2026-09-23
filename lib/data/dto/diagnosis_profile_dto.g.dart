// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiagnosisProfileDto _$DiagnosisProfileDtoFromJson(Map<String, dynamic> json) =>
    DiagnosisProfileDto(
      background: json['background'] as String,
      difficultyScore: (json['difficultyScore'] as num).toInt(),
      purposeTags: (json['purposeTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      weakAreas: (json['weakAreas'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$DiagnosisProfileDtoToJson(
  DiagnosisProfileDto instance,
) => <String, dynamic>{
  'background': instance.background,
  'difficultyScore': instance.difficultyScore,
  'purposeTags': instance.purposeTags,
  'weakAreas': instance.weakAreas,
  'timestamp': instance.timestamp.toIso8601String(),
};
