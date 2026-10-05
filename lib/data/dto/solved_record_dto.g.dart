// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solved_record_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolvedRecordDto _$SolvedRecordDtoFromJson(Map<String, dynamic> json) =>
    SolvedRecordDto(
      quiz: QuizDto.fromJson(json['quiz'] as Map<String, dynamic>),
      userAnswer: json['userAnswer'] as String,
      timestamp: const TimestampConverter().fromJson(
        json['timestamp'] as Object,
      ),
      quizFeedback: QuizFeedbackDto.fromJson(
        json['quizFeedback'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SolvedRecordDtoToJson(SolvedRecordDto instance) =>
    <String, dynamic>{
      'quiz': instance.quiz.toJson(),
      'userAnswer': instance.userAnswer,
      'quizFeedback': instance.quizFeedback.toJson(),
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
