import 'package:hontudy/di/repository_providers.dart';
import 'package:hontudy/domain/models/diagnosis_turn.dart';
import 'package:hontudy/presentation/state/diagnosis_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'diagnosis_viewmodel.g.dart';

@riverpod
class DiagnosisViewModel extends _$DiagnosisViewModel {
  static const maxTurns = 8;

  static const _maxOffTopic = 3;
  static const _offTopicNotice =
      '혼터디는 IT·CS 학습을 돕는 서비스예요. 위 질문에 답해 주시면 맞춤 진단을 이어갈게요.';
  static const _restartNotice = '진단과 관련 없는 답변이 이어져서 처음 질문부터 다시 시작할게요.';

  @override
  DiagnosisState build() => _initialState();

  DiagnosisState _initialState({String? notice}) {
    return DiagnosisState(
      messages: [
        if (notice != null)
          DiagnosisMessage.aiNotice(
            id: _newId(),
            createdAt: _now(),
            text: notice,
          ),
        DiagnosisMessage.aiQuestion(
          id: _newId(),
          createdAt: _now(),
          questionText: '혼터디에 오신 것을 환영합니다\n어떤 공부를 하고 싶으신가요?',
          content: const DiagnosisContent.singleChoiceList(
            options: [
              'CS 핵심 전반적인 기본기 다지고 싶어요',
              '취업·이직을 준비하고 있어요',
              '기술 면접 단골 질문 위주로 준비하고 싶어요',
            ],
          ),
        ),
      ],
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
      case DiagnosisNextAction.offTopic:
        _handleOffTopic();
    }
  }

  void _handleOffTopic() {
    final last = state.messages.last;
    final marked = [
      ...state.messages.take(state.messages.length - 1),
      if (last is UserAnswer) last.copyWith(offTopic: true) else last,
    ];
    final withMarked = state.copyWith(messages: marked);

    if (withMarked.offTopicStreak >= _maxOffTopic) {
      state = _initialState(notice: _restartNotice);
      return;
    }
    state = withMarked.copyWith(
      messages: [
        ...marked,
        DiagnosisMessage.aiNotice(
          id: _newId(),
          createdAt: _now(),
          text: _offTopicNotice,
        ),
      ],
      phase: const DiagnosisPhase.waitingAnswer(),
    );
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
