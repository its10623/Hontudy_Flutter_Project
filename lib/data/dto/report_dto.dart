import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/data/dto/quiz_dto.dart';
import 'package:hontudy/data/dto/timestamp_converter.dart';

import '../../domain/models/report.dart';

part 'report_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportDto {
  final String uid;
  final String userPrompt;
  final String aiResponse;
  final ReportReason reportReason;
  final QuizDto? quiz;
  final ReportScreen reportScreen;
  final String? description;
  final String appVersion;
  @TimestampConverter()
  final DateTime timestamp;

  ReportDto({
    required this.uid,
    required this.userPrompt,
    required this.aiResponse,
    required this.reportReason,
    required this.timestamp,
    this.description,
    required this.appVersion,
    this.quiz,
    required this.reportScreen,
  });

  factory ReportDto.fromJson(Map<String, dynamic> json) =>
      _$ReportDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDtoToJson(this);
}

class ReportMapper {
  static Report toDomain(ReportDto dto) {
    return Report(
      userPrompt: dto.userPrompt,
      aiResponse: dto.aiResponse,
      reportReason: dto.reportReason,
      reportScreen: dto.reportScreen,
      quiz: dto.quiz == null ? null : QuizMapper.toDomain(dto.quiz!),
      description: dto.description,
      timestamp: dto.timestamp,
    );
  }

  static ReportDto toDto(Report model, String uid, String appVersion) {
    return ReportDto(
      uid: uid,
      userPrompt: model.userPrompt,
      aiResponse: model.aiResponse,
      reportReason: model.reportReason,
      reportScreen: model.reportScreen,
      quiz: model.quiz == null ? null : QuizMapper.toDto(model.quiz!),
      description: model.description,
      timestamp: model.timestamp,
      appVersion: appVersion,
    );
  }
}
