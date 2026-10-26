// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDto _$ReportDtoFromJson(Map<String, dynamic> json) => ReportDto(
  uid: json['uid'] as String,
  userPrompt: json['userPrompt'] as String,
  aiResponse: json['aiResponse'] as String,
  reportReason: $enumDecode(_$ReportReasonEnumMap, json['reportReason']),
  timestamp: const TimestampConverter().fromJson(json['timestamp'] as Object),
  description: json['description'] as String?,
  appVersion: json['appVersion'] as String,
  quiz: json['quiz'] == null
      ? null
      : QuizDto.fromJson(json['quiz'] as Map<String, dynamic>),
  reportScreen: $enumDecode(_$ReportScreenEnumMap, json['reportScreen']),
);

Map<String, dynamic> _$ReportDtoToJson(ReportDto instance) => <String, dynamic>{
  'uid': instance.uid,
  'userPrompt': instance.userPrompt,
  'aiResponse': instance.aiResponse,
  'reportReason': _$ReportReasonEnumMap[instance.reportReason]!,
  'quiz': instance.quiz?.toJson(),
  'reportScreen': _$ReportScreenEnumMap[instance.reportScreen]!,
  'description': instance.description,
  'appVersion': instance.appVersion,
  'timestamp': const TimestampConverter().toJson(instance.timestamp),
};

const _$ReportReasonEnumMap = {
  ReportReason.inappropriate: 'inappropriate',
  ReportReason.hallucination: 'hallucination',
  ReportReason.privacyLeak: 'privacyLeak',
  ReportReason.incorrectData: 'incorrectData',
  ReportReason.other: 'other',
};

const _$ReportScreenEnumMap = {
  ReportScreen.diagnosis: 'diagnosis',
  ReportScreen.quiz: 'quiz',
};
