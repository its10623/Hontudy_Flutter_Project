
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/domain/models/quiz.dart';

part 'quiz_feedback.freezed.dart';

@freezed
class QuizFeedback with _$QuizFeedback {
  final bool isCorrect;
  final String feedbackText;
  final String? keyPoint;
  final CodeSnippet? codeSnippet;
  final String? imageUrl;

  const QuizFeedback({
    required this.isCorrect,
    required this.feedbackText,
    this.keyPoint,
    this.codeSnippet,
    this.imageUrl,
  });
}
