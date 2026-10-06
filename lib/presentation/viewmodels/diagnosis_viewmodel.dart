import 'package:hontudy/di/repository_providers.dart';
import 'package:hontudy/domain/models/diagnosis_turn.dart';
import 'package:hontudy/presentation/state/diagnosis_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'diagnosis_viewmodel.g.dart';

@riverpod
class DiagnosisViewModel extends _$DiagnosisViewModel {
  static const maxTurns = 8;

  @override
  DiagnosisState build() {
    final message = DiagnosisMessage.aiQuestion(
      id: _newId(),
      createdAt: _now(),
      questionText: '혼터디에 오신 것을 환영합니다\n어떤 공부를 하고 싶으신가요?',
      content: const DiagnosisContent.singleChoiceList(
        options: ['언어 공부 하고 싶습니다', 'CS 공부하고 싶습니다'],
      ),
    );
    return DiagnosisState(
      messages: [message],
      phase: const DiagnosisPhase.waitingAnswer(),
    );
  }

  Future<void> submitAnswer(String text) async {
    if (state.phase is! WaitingAnswer) return;
    final userAnswer = DiagnosisMessage.userAnswer(
      id: _newId(),
      createdAt: _now(),
      text: text,
    );
    state = state.copyWith(
      messages: [...state.messages, userAnswer],
      phase: const DiagnosisPhase.sending(),
    );

    if (state.turnCount >= maxTurns) {
      await _classify();
    } else {
      await _requestNextTurn();
    }
  }

  Future<void> retry() async {
    if (state.phase case Failed(:final retryTarget)) {
      switch (retryTarget) {
        case DiagnosisRetryTarget.turn:
          await _requestNextTurn();
        case DiagnosisRetryTarget.classification:
          await _classify();
      }
    }
  }

  Future<void> confirm({required bool remember}) async {
    if (state.phase is! Confirming) return;
    final profile = state.summaryResult?.profile;
    if (profile == null) throw StateError('요약이 없습니다');
    if (remember) {
      final result = await ref
          .read(diagnosisRepositoryProvider)
          .saveDiagnosisProfile(profile);
      if (!ref.mounted) return;
      result.fold(
        (success) => success,
        (failure) => throw failure,
      );
    }
    state = state.copyWith(phase: DiagnosisPhase.completed(profile: profile));
  }

  Future<void> _requestNextTurn() async {
    state = state.copyWith(phase: const DiagnosisPhase.sending());

    final result = await ref
        .read(diagnosisRepositoryProvider)
        .requestDiagnosisTurn(state.history);
    if (!ref.mounted) return;

    final turn = result.getOrNull();
    if (turn == null) {
      state = state.copyWith(
        phase: DiagnosisPhase.failed(
          error: result.exceptionOrNull()!,
          retryTarget: DiagnosisRetryTarget.turn,
        ),
      );
      return;
    }

    switch (turn.nextAction) {
      case DiagnosisNextAction.continueDiagnosis:
        state = state.copyWith(
          messages: [
            ...state.messages,
            DiagnosisMessage.aiQuestion(
              id: _newId(),
              createdAt: _now(),
              questionText: turn.questionText,
              content: turn.diagnosisContent,
            ),
          ],
          phase: const DiagnosisPhase.waitingAnswer(),
        );
      case DiagnosisNextAction.readyToClassify:
      case DiagnosisNextAction.userRequestedProblem:
        await _classify();
    }
  }

  Future<void> _classify() async {
    state = state.copyWith(phase: const DiagnosisPhase.classifying());
    final result = await ref
        .read(diagnosisRepositoryProvider)
        .requestDiagnosisClassification(state.history);
    if (!ref.mounted) return;
    result.fold(
      (diagnosisResult) {
        state = state.copyWith(
          messages: [
            ...state.messages,
            DiagnosisMessage.aiSummary(
              id: _newId(),
              createdAt: _now(),
              result: diagnosisResult,
            ),
          ],
          phase: const DiagnosisPhase.confirming(),
        );
      },
      (error) {
        state = state.copyWith(
          phase: DiagnosisPhase.failed(
            error: error,
            retryTarget: DiagnosisRetryTarget.classification,
          ),
        );
      },
    );
  }

  String _newId() => const Uuid().v4();

  DateTime _now() => DateTime.now();
}
