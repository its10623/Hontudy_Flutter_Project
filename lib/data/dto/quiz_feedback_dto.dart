import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/data/dto/quiz_dto.dart';
import 'package:hontudy/domain/models/quiz_feedback.dart';

part 'quiz_feedback_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizFeedbackDto {
  final bool isCorrect;
  final String feedbackText;
  final String? keyPoint;
  final CodeSnippetDto? codeSnippet;
  final String? imageUrl;

  const QuizFeedbackDto({
    required this.isCorrect,
    required this.feedbackText,
    this.keyPoint,
    this.codeSnippet,
    this.imageUrl,
  });

  factory QuizFeedbackDto.fromJson(Map<String, dynamic> json) =>
      _$QuizFeedbackDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuizFeedbackDtoToJson(this);
}

class QuizFeedbackMapper {
  static QuizFeedback toDomain(QuizFeedbackDto dto) {
    return QuizFeedback(
      isCorrect: dto.isCorrect,
      feedbackText: dto.feedbackText,
      keyPoint: dto.keyPoint,
      codeSnippet: dto.codeSnippet == null
          ? null
          : CodeSnippetMapper.toDomain(dto.codeSnippet!),
      imageUrl: dto.imageUrl,
    );
  }

  static QuizFeedbackDto toDto(QuizFeedback model) {
    return QuizFeedbackDto(
      isCorrect: model.isCorrect,
      feedbackText: model.feedbackText,
      keyPoint: model.keyPoint,
      codeSnippet: model.codeSnippet == null
          ? null
          : CodeSnippetMapper.toDto(model.codeSnippet!),
      imageUrl: model.imageUrl,
    );
  }
}
