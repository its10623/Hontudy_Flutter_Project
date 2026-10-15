import 'package:hontudy/presentation/views/route/app_router.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/domain/models/diagnosis_turn.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/state/diagnosis_state.dart';
import 'package:hontudy/presentation/viewmodels/diagnosis_viewmodel.dart';

import '../../../domain/exceptions.dart';
import '../../core/theme/context_theme_extension.dart';
import '../component/app_background.dart';
import '../component/chat/chat_appbar.dart';
import '../component/chat/chat_body.dart';
import '../component/dialog_widget.dart';
import '../component/error_dialog.dart';
import '../component/genui/diagnosis_choice_list.dart';
import '../component/genui/filter_chip_gen_ui.dart';
import '../component/genui/summary_confirm.dart';
import '../component/primary_button.dart';
import '../component/shimmer_wrapper.dart';
import '../component/skeleton_box.dart';

class DiagnosisChatPage extends ConsumerStatefulWidget {
  const DiagnosisChatPage({super.key});

  @override
  ConsumerState<DiagnosisChatPage> createState() => _DiagnosisChatPageState();
}

class _DiagnosisChatPageState extends ConsumerState<DiagnosisChatPage> {
  static const _statusId = 'diagnosis-status';

  final _controller = ChatMessagesController(
    paginationConfig: const PaginationConfig(reverseOrder: false),
  );

  @override
  void initState() {
    super.initState();
    _controller.setMessages(
      _toChatMessages(ref.read(diagnosisViewModelProvider)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(diagnosisViewModelProvider, (previous, next) {
      _controller.setMessages(_toChatMessages(next));
      if (kDebugMode) {
        if (next.phase case Failed(:final error)) {
          debugPrint('[Diagnosis] 요청 실패: $error');
        }
      }
      if (next.phase case Completed(
        :final profile,
      ) when previous?.phase is! Completed) {
        context.go(AppRoutes.home, extra: profile);
      }
    });

    final state = ref.watch(diagnosisViewModelProvider);
    final notifier = ref.read(diagnosisViewModelProvider.notifier);
    const maxTurns = DiagnosisViewModel.maxTurns;
    final questionNumber = min(state.turnCount + 1, maxTurns);
    final isSummary = state.summaryResult != null;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: ChatAppbar(
          pageInfo: '혼터디 AI · 맞춤 문제 진단',
          currentState: isSummary ? '진단 결과 확인' : '$questionNumber번째 질문',
          progress: isSummary ? 1 : questionNumber / (maxTurns + 1),
        ),
        body: ChatBody(
          controller: _controller,
          inputEnabled: state.phase is WaitingAnswer,
          onSend: notifier.submitAnswer,
          footerBuilder: (context, message) =>
              _buildFooter(state, message.customProperties?['id']),
        ),
      ),
    );
  }

  List<ChatMessage> _toChatMessages(DiagnosisState state) {
    return [
      for (final message in state.messages)
        ChatMessage(
          text: switch (message) {
            AiQuestion(:final questionText) => questionText,
            UserAnswer(:final text) => text,
            AiSummary() => '진단 결과를 정리했어요. 맞는지 확인해 주세요.',
            AiNotice(:final text) => text,
          },
          user: message is UserAnswer ? chatCurrentUser : chatAiUser,
          createdAt: message.createdAt,
          customProperties: {'id': message.id},
        ),
      if (state.phase is Sending ||
          state.phase is Classifying ||
          state.phase is Failed)
        ChatMessage(
          text: switch (state.phase) {
            Failed(error: AiUsageLimitExceededException()) =>
              '하루 사용 한도 초과 했어요.\n내일 다시 진단 해주세요',
            Failed() => '응답을 받지 못했어요.',
            _ => '',
          },
          user: chatAiUser,
          createdAt: DateTime.now(),
          customProperties: {'id': _statusId},
        ),
    ];
  }

  Widget? _buildFooter(DiagnosisState state, Object? id) {
    if (id == _statusId) {
      return switch (state.phase) {
        Failed(error: AiUsageLimitExceededException()) => null,
        Failed() => PrimaryButton(
          onPressed: ref.read(diagnosisViewModelProvider.notifier).retry,
          text: '다시 시도',
          color: ButtonColor.surface,
        ),
        _ => const _ThinkingSkeleton(),
      };
    }

    final message = state.messages.where((m) => m.id == id).firstOrNull;
    return switch (message) {
      AiQuestion(:final content) => _buildQuestionWidget(
        content,
        enabled: state.activeQuestion?.id == id,
        answer: state.answersByQuestionId[id],
      ),
      AiSummary(:final result) => SummaryConfirm(
        result: result,
        enabled: state.phase is Confirming,
        onConfirm: _confirm,
        onRediagnose: _confirmRediagnose,
      ),
      _ => null,
    };
  }

  Widget? _buildQuestionWidget(
    DiagnosisContent content, {
    required bool enabled,
    required String? answer,
  }) {
    final notifier = ref.read(diagnosisViewModelProvider.notifier);
    final choices = switch (content) {
      SingleChoiceListContent(:final options) => DiagnosisChoiceList(
        options: options,
        enabled: enabled,
        answer: answer,
        onSelected: notifier.submitAnswer,
      ),
      ChoiceChipsContent(:final options) => FilterChipGenUi(
        options: options,
        enabled: enabled,
        answer: answer,
        onSubmit: (selected) => notifier.submitAnswer(selected.join(', ')),
      ),
      FreeTextInputContent() || SummaryConfirmContent() => null,
    };
    if (choices == null || enabled || answer == null) return choices;
    return _AnsweredChoices(answer: answer, choices: choices);
  }

  Future<void> _confirmRediagnose() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => DialogWidget(
        title: '다시 진단하기',
        content: '지금까지의 답변을 지우고 처음 질문부터 다시 진단해요.',
        secondaryText: '취소',
        secondaryOnPressed: () => Navigator.of(dialogContext).pop(false),
        primaryText: '다시 진단하기',
        primaryOnPressed: () => Navigator.of(dialogContext).pop(true),
      ),
    );
    if (confirmed != true || !mounted) return;
    ref.read(diagnosisViewModelProvider.notifier).restart();
  }

  Future<void> _confirm(bool remember) async {
    try {
      await ref
          .read(diagnosisViewModelProvider.notifier)
          .confirm(remember: remember);
    } catch (error) {
      if (!mounted) return;
      await ErrorDialog.show(context: context, error: error);
    }
  }
}

class _AnsweredChoices extends StatefulWidget {
  final String answer;
  final Widget choices;

  const _AnsweredChoices({required this.answer, required this.choices});

  @override
  State<_AnsweredChoices> createState() => _AnsweredChoicesState();
}

class _AnsweredChoicesState extends State<_AnsweredChoices> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final primary = context.colors.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          borderRadius: AppShape.option,
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, size: 20, color: primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.answer,
                    style: context.textStyles.bodySmall,
                    maxLines: _expanded ? null : 1,
                    overflow: _expanded ? null : TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: context.colors.outline,
                ),
              ],
            ),
          ),
        ),
        if (_expanded) ...[const SizedBox(height: 8), widget.choices],
      ],
    );
  }
}

class _ThinkingSkeleton extends StatelessWidget {
  const _ThinkingSkeleton();

  @override
  Widget build(BuildContext context) {
    return const ShimmerWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(
            width: 180,
            height: 14,
            borderRadius: AppShape.skeletonBar,
          ),
          SizedBox(height: 8),
          SkeletonBox(
            width: 120,
            height: 14,
            borderRadius: AppShape.skeletonBar,
          ),
        ],
      ),
    );
  }
}
