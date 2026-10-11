import 'package:hontudy/di/use_case_providers.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/use_cases/request_quiz_use_case.dart';
import 'package:hontudy/presentation/state/quiz_state.dart';
import 'package:hontudy/presentation/viewmodels/note_detail_viewmodel.dart';
import 'package:hontudy/presentation/viewmodels/note_summary_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_viewmodel.g.dart';

@riverpod
class QuizViewModel extends _$QuizViewModel {
  @override
  QuizState build(DiagnosisProfile? profile) {
    // 진단 직후에만 바로 출제하고, 앱을 다시 켠 경우엔 사용자가 시작을 누를 때까지 기다림
    if (profile == null) return const QuizState(phase: QuizPhase.idle());
    Future.microtask(_requestQuiz);
    return const QuizState(phase: QuizPhase.loadingQuiz());
  }

  Future<void> start() async {
    if (state.phase is! Idle) return;
    await _requestQuiz();
  }

  Future<void> submitAnswer(String answer) async {
    if (state.phase is! Answering) return;
    state = state.copyWith(
      userAnswer: answer,
      phase: const QuizPhase.grading(),
    );
    await _grade();
  }

  Future<void> retry() async {
    if (state.phase case QuizFailed(:final retryTarget)) {
      switch (retryTarget) {
        case QuizRetryTarget.retryQuiz:
          await _requestQuiz();
        case QuizRetryTarget.retryGrade:
          state = state.copyWith(phase: const QuizPhase.grading());
          await _grade();
      }
    }
  }

  void answerAgain() {
    final quiz = state.quiz;
    if (state.phase is! Graded || quiz == null) return;
    if (state.feedback?.isOffTopic != true) return;
    state = QuizState(quiz: quiz, phase: const QuizPhase.answering());
  }

  Future<void> nextQuiz() async {
    if (state.phase is! Graded && state.phase is! ReviewMode) return;
    await _requestQuiz();
  }

  Future<void> _requestQuiz() async {
    state = const QuizState(phase: QuizPhase.loadingQuiz());
    try {
      final result = await ref
          .read(requestQuizUseCaseProvider)
          .call(diagnosisProfile: profile);
      if (!ref.mounted) return;
      state = switch (result) {
        QuizReady(:final quiz) => QuizState(
          quiz: quiz,
          phase: const QuizPhase.answering(),
        ),
        ReviewModeRequired() => const QuizState(
          phase: QuizPhase.reviewMode(),
        ),
      };
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        phase: QuizPhase.quizFailed(
          error: e,
          retryTarget: QuizRetryTarget.retryQuiz,
        ),
      );
    }
  }

  Future<void> _grade() async {
    try {
      final feedback = await ref
          .read(submitQuizAnswerUseCaseProvider)
          .call(quiz: state.quiz!, userAnswer: state.userAnswer!);
      if (!ref.mounted) return;
      if (!feedback.isOffTopic) {
        ref
          ..invalidate(noteSummaryViewModelProvider)
          ..invalidate(noteDetailViewModelProvider);
      }
      state = state.copyWith(
        feedback: feedback,
        phase: const QuizPhase.graded(),
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        phase: QuizPhase.quizFailed(
          error: e,
          retryTarget: QuizRetryTarget.retryGrade,
        ),
      );
    }
  }
}
