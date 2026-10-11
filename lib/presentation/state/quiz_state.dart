import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/domain/models/quiz_feedback.dart';

import '../../domain/models/quiz.dart';

part 'quiz_state.freezed.dart';

@freezed
class QuizState with _$QuizState {
  final Quiz? quiz;
  final String? userAnswer;
  final QuizFeedback? feedback;
  final QuizPhase phase;

  const QuizState({
    this.quiz,
    this.userAnswer,
    this.feedback,
    required this.phase,
  });
}

@freezed
sealed class QuizPhase with _$QuizPhase {
  const QuizPhase._();

  const factory QuizPhase.idle() = Idle;
  const factory QuizPhase.answering() = Answering;
  const factory QuizPhase.loadingQuiz() = LoadingQuiz;
  const factory QuizPhase.grading() = Grading;
  const factory QuizPhase.graded() = Graded;
  const factory QuizPhase.quizFailed({
    required Object error,
    required QuizRetryTarget retryTarget,
  }) = QuizFailed;
  const factory QuizPhase.reviewMode() = ReviewMode;
}

enum QuizRetryTarget { retryQuiz, retryGrade }
