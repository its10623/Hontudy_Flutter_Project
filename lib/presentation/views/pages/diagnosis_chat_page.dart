import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/di/repository_providers.dart';
import 'package:hontudy/domain/models/diagnosis_turn.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/state/diagnosis_state.dart';
import 'package:hontudy/presentation/viewmodels/diagnosis_viewmodel.dart';
import 'package:hontudy/presentation/views/pages/quiz_chat_page.dart';
import 'package:hontudy/presentation/views/pages/sign_in_page.dart';

import '../../core/theme/context_theme_extension.dart';
import '../component/app_background.dart';
import '../component/chat/chat_appbar.dart';
import '../component/chat/chat_body.dart';
import '../component/error_dialog.dart';
import '../component/genui/diagnosis_choice_chip.dart';
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
      if (next.phase case Failed(:final error)) {
        debugPrint('[Diagnosis] 요청 실패: $error');
      }
      if (next.phase case Completed(
        :final profile,
      ) when previous?.phase is! Completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => QuizChatPage(profile: profile)),
        );
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
          currentState: isSummary
              ? '진단 결과 확인'
              : '$questionNumber번째 질문',
          progress: isSummary ? 1 : questionNumber / maxTurns,
        ),
        body: ChatBody(
          controller: _controller,
          inputEnabled: state.phase is WaitingAnswer,
          onSend: notifier.submitAnswer,
          footerBuilder: (context, message) =>
              _buildFooter(state, message.customProperties?['id']),
        ),
        // TODO(임시): 프로필 화면 로그아웃이 연결되면(라우팅 작업 시) 삭제
        floatingActionButton: kDebugMode ? const _DebugAccountBar() : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
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
          },
          user: message is UserAnswer ? chatCurrentUser : chatAiUser,
          createdAt: message.createdAt,
          customProperties: {'id': message.id},
        ),
      if (state.phase is Sending ||
          state.phase is Classifying ||
          state.phase is Failed)
        ChatMessage(
          text: state.phase is Failed ? '응답을 받지 못했어요.' : '',
          user: chatAiUser,
          createdAt: DateTime.now(),
          customProperties: {'id': _statusId},
        ),
    ];
  }

  Widget? _buildFooter(DiagnosisState state, Object? id) {
    if (id == _statusId) {
      return state.phase is Failed
          ? PrimaryButton(
              onPressed: ref.read(diagnosisViewModelProvider.notifier).retry,
              text: '다시 시도',
              color: ButtonColor.surface,
            )
          : const _ThinkingSkeleton();
    }

    final message = state.messages.where((m) => m.id == id).firstOrNull;
    return switch (message) {
      AiQuestion(:final content) => _buildQuestionWidget(
        content,
        enabled: state.activeQuestion?.id == id,
      ),
      AiSummary(:final result) => SummaryConfirm(
        result: result,
        enabled: state.phase is Confirming,
        onConfirm: _confirm,
      ),
      _ => null,
    };
  }

  Widget? _buildQuestionWidget(
    DiagnosisContent content, {
    required bool enabled,
  }) {
    final notifier = ref.read(diagnosisViewModelProvider.notifier);
    return switch (content) {
      SingleChoiceListContent(:final options) => DiagnosisChoiceChip(
        options: options,
        enabled: enabled,
        onSelected: notifier.submitAnswer,
      ),
      ChoiceChipsContent(:final options) => FilterChipGenUi(
        options: options,
        enabled: enabled,
        onSubmit: (selected) => notifier.submitAnswer(selected.join(', ')),
      ),
      FreeTextInputContent() || SummaryConfirmContent() => null,
    };
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

/// 디버그 빌드 전용: 현재 계정(제공업체·이름·이메일) 확인 + 로그아웃.
/// Apple 최초 로그인 이름 저장, Android 웹 흐름의 이름 반영 여부를 앱에서 바로 보려고 둔 것.
class _DebugAccountBar extends ConsumerWidget {
  const _DebugAccountBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userRepositoryProvider).currentUser;
    final name = (user?.displayName.isNotEmpty ?? false)
        ? user!.displayName
        : '(이름 없음)';
    final label = user == null
        ? '로그인 안 됨'
        : '[${user.authProvider.name}] $name · ${user.email}';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 260),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: context.captionSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const _DebugSignOutButton(),
      ],
    );
  }
}

/// 디버그 빌드 전용 임시 로그아웃 버튼.
/// 로그인 테스트를 반복하려고 둔 것이라 ViewModel 없이 Repository를 직접 부른다.
class _DebugSignOutButton extends ConsumerWidget {
  const _DebugSignOutButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.small(
      heroTag: 'debugSignOut',
      tooltip: '로그아웃 (디버그)',
      onPressed: () async {
        final result = await ref.read(userRepositoryProvider).signOut();
        if (!context.mounted) return;
        result.fold(
          (_) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const SignInPage()),
            (_) => false,
          ),
          (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그아웃 실패: $error')),
          ),
        );
      },
      child: const Icon(Icons.logout),
    );
  }
}
