import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/domain/models/quiz.dart';
import 'package:hontudy/domain/models/quiz_feedback.dart';

part 'solved_record.freezed.dart';

@freezed
class SolvedRecord with _$SolvedRecord {
  final Quiz quiz;
  final String userAnswer;
  final QuizFeedback quizFeedback;
  final DateTime timestamp;

  const SolvedRecord({
    required this.quiz,
    required this.userAnswer,
    required this.timestamp,
    required this.quizFeedback,
  });
}
