import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/data/dto/quiz_dto.dart';
import 'package:hontudy/data/dto/quiz_feedback_dto.dart';
import 'package:hontudy/domain/models/solved_record.dart';

part 'solved_record_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SolvedRecordDto {
  final QuizDto quiz;
  final String userAnswer;
  final QuizFeedbackDto quizFeedback;
  final DateTime timestamp;

  const SolvedRecordDto({
    required this.quiz,
    required this.userAnswer,
    required this.timestamp,
    required this.quizFeedback,
  });

  factory SolvedRecordDto.fromJson(Map<String, dynamic> json) =>
      _$SolvedRecordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SolvedRecordDtoToJson(this);
}

class SolvedRecordMapper {
  static SolvedRecord toDomain(SolvedRecordDto dto) {
    return SolvedRecord(
      quiz: QuizMapper.toDomain(dto.quiz),
      userAnswer: dto.userAnswer,
      timestamp: dto.timestamp,
      quizFeedback: QuizFeedbackMapper.toDomain(dto.quizFeedback),
    );
  }

  static SolvedRecordDto toDto(SolvedRecord model) {
    return SolvedRecordDto(
      quiz: QuizMapper.toDto(model.quiz),
      userAnswer: model.userAnswer,
      timestamp: model.timestamp,
      quizFeedback: QuizFeedbackMapper.toDto(model.quizFeedback),
    );
  }
}
