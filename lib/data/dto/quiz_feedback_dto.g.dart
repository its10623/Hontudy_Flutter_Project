// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_feedback_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizFeedbackDto _$QuizFeedbackDtoFromJson(Map<String, dynamic> json) =>
    QuizFeedbackDto(
      isCorrect: json['isCorrect'] as bool,
      feedbackText: json['feedbackText'] as String,
      keyPoint: json['keyPoint'] as String?,
      codeSnippet: json['codeSnippet'] == null
          ? null
          : CodeSnippetDto.fromJson(
              json['codeSnippet'] as Map<String, dynamic>,
            ),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$QuizFeedbackDtoToJson(QuizFeedbackDto instance) =>
    <String, dynamic>{
      'isCorrect': instance.isCorrect,
      'feedbackText': instance.feedbackText,
      'keyPoint': instance.keyPoint,
      'codeSnippet': instance.codeSnippet?.toJson(),
      'imageUrl': instance.imageUrl,
    };
