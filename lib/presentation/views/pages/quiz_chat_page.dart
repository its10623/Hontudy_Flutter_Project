import 'package:hontudy/presentation/views/route/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hontudy/domain/exceptions.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/models/quiz.dart';
import 'package:hontudy/domain/models/quiz_feedback.dart';
import 'package:hontudy/presentation/core/theme/main_category_style.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';
import 'package:hontudy/presentation/state/quiz_state.dart';
import 'package:hontudy/presentation/viewmodels/quiz_viewmodel.dart';

import '../../core/theme/context_theme_extension.dart';
import '../component/app_background.dart';
import '../component/chat/chat_appbar.dart';
import '../component/chat/chat_body.dart';
import '../component/genui/answer_feedback.dart';
import '../component/genui/code_block.dart';
import '../component/genui/image_widget.dart';
import '../component/genui/quiz_choice_chip.dart';
import '../component/primary_button.dart';
import '../component/shimmer_wrapper.dart';
import '../component/skeleton_box.dart';

class QuizChatPage extends ConsumerStatefulWidget {
  final DiagnosisProfile? profile;

  const QuizChatPage({super.key, this.profile});

  @override
  ConsumerState<QuizChatPage> createState() => _QuizChatPageState();
}

class _QuizChatPageState extends ConsumerState<QuizChatPage> {
  static const _quizId = 'quiz';
  static const _answerId = 'answer';
  static const _feedbackId = 'feedback';
  static const _statusId = 'status';

  final _controller = ChatMessagesController(
    paginationConfig: const PaginationConfig(reverseOrder: false),
  );
  final _times = <String, DateTime>{};

  QuizViewModelProvider get _provider => quizViewModelProvider(widget.profile);

  @override
  void initState() {
    super.initState();
    _controller.setMessages(_toChatMessages(ref.read(_provider)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(_provider, (_, next) {
      _controller.setMessages(_toChatMessages(next));
      if (kDebugMode) {
        if (next.phase case QuizFailed(:final error)) {
          debugPrint('[Quiz] 요청 실패: $error');
        }
      }
    });

    final state = ref.watch(_provider);
    final notifier = ref.read(_provider.notifier);
    final quiz = state.quiz;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: ChatAppbar(
          pageInfo: quiz == null
              ? '혼터디 AI · 문제풀이'
              : '문제풀이 · ${quiz.category.main}',
          currentState: _headerState(state),
          onNote: _HeaderLink(
            icon: Icons.menu_book_outlined,
            onTap: () => context.go(AppRoutes.note),
          ),
          onProfile: _HeaderLink(
            icon: Icons.person_outline_rounded,
            onTap: () => context.go(AppRoutes.profile),
          ),
        ),
        body: state.phase is Idle
            ? _QuizStartView(onStart: notifier.start)
            : ChatBody(
                controller: _controller,
                inputEnabled:
                    state.phase is Answering &&
                    quiz?.quizContent is ShortAnswerContent,
                inputHint: _inputHint(state),
                afterBuilder: (context, message) =>
                    message.customProperties?['id'] != _statusId
                    ? null
                    : switch (state.phase) {
                        LoadingQuiz() => const _WorkingIndicator(
                          '문제를 만들고 있어요 · 최대 10초',
                        ),
                        Grading() => const _WorkingIndicator(
                          '열심히 채점 중이에요 · 최대 10초',
                        ),
                        _ => null,
                      },
                onSend: notifier.submitAnswer,
                footerBuilder: (context, message) =>
                    _buildFooter(state, message.customProperties?['id']),
              ),
      ),
    );
  }

  String _headerState(QuizState state) => switch (state.phase) {
    Idle() => '오늘의 문제',
    LoadingQuiz() => '문제 준비 중',
    Answering() => '난이도 ${state.quiz?.difficulty ?? ''}',
    Grading() => '채점 중',
    Graded() => '채점 완료',
    QuizFailed(error: AiUsageLimitExceededException()) => '하루 사용 한도 초과',
    QuizFailed() => '잠시 문제가 생겼어요',
    ReviewMode() => '복습 모드',
  };

  String _inputHint(QuizState state) => switch (state.phase) {
    Answering() when state.quiz?.quizContent is ShortAnswerContent =>
      '답을 입력해주세요',
    Answering() => '보기에서 답을 골라주세요',
    LoadingQuiz() => '문제가 준비되면 입력할 수 있어요',
    Grading() => '채점이 끝나면 입력할 수 있어요',
    _ => '다음 문제를 눌러 계속해요',
  };

  List<ChatMessage> _toChatMessages(QuizState state) {
    if (state.quiz == null) _times.clear();
    final quiz = state.quiz;
    final answer = state.userAnswer;
    final feedback = state.feedback;
    final phase = state.phase;
    final showStatus =
        phase is! Answering && phase is! Graded && phase is! Idle;
    if (!showStatus) _times.remove(_statusId);

    return [
      if (quiz != null) _aiMessage(_quizId, quiz.questionText),
      if (answer != null)
        ChatMessage(
          text: answer,
          user: chatCurrentUser,
          createdAt: _timeOf(_answerId),
          customProperties: {'id': _answerId},
        ),
      if (feedback != null)
        _aiMessage(
          _feedbackId,
          switch (feedback) {
            QuizFeedback(isOffTopic: true) => '문제와 관련된 답을 적어 주세요.',
            QuizFeedback(isCorrect: true) => '정답이에요!',
            _ => '아쉽지만 오답이에요.',
          },
        ),
      if (showStatus)
        _aiMessage(_statusId, switch (phase) {
          QuizFailed(error: AiUsageLimitExceededException()) => '하루 사용 한도 초과 했어요\n내일 다시 풀 수 있어요',
          QuizFailed() => '응답을 받지 못했어요.',
          ReviewMode() => '지금 수준에서 낼 수 있는 새 문제를 모두 풀었어요. 조금 뒤에 다시 받아 보세요.',
          _ => '',
        }),
    ];
  }

  ChatMessage _aiMessage(String id, String text) {
    return ChatMessage(
      text: text,
      user: chatAiUser,
      createdAt: _timeOf(id),
      customProperties: {'id': id},
    );
  }

  DateTime _timeOf(String id) => _times.putIfAbsent(id, DateTime.now);

  Widget? _buildFooter(QuizState state, Object? id) {
    final notifier = ref.read(_provider.notifier);
    final phase = state.phase;
    final quiz = state.quiz;
    final feedback = state.feedback;

    return switch (id) {
      _quizId when quiz != null => _QuizCard(
        quiz: quiz,
        enabled: phase is Answering,
        submittedAnswer: state.userAnswer,
        showResult: feedback != null,
        onSubmit: notifier.submitAnswer,
      ),
      _feedbackId when quiz != null && feedback != null => _FeedbackCard(
        quiz: quiz,
        feedback: feedback,
        onNext: phase is Graded ? notifier.nextQuiz : null,
        onAnswerAgain: phase is Graded && feedback.isOffTopic
            ? notifier.answerAgain
            : null,
      ),
      _statusId => switch (phase) {
        QuizFailed(error: DiagnosisProfileEmptyException()) => PrimaryButton(
          onPressed: () => context.go(AppRoutes.diagnosis),
          text: '진단하러 가기',
          color: ButtonColor.primary,
        ),
        QuizFailed(error: AiUsageLimitExceededException()) => PrimaryButton(
          onPressed: () => StatefulNavigationShell.of(context).goBranch(1),
          text: '복습하러 가기',
          color: ButtonColor.primary,
        ),
        QuizFailed() => PrimaryButton(
          onPressed: notifier.retry,
          text: '다시 시도',
          color: ButtonColor.surface,
        ),
        ReviewMode() => PrimaryButton(
          onPressed: notifier.nextQuiz,
          text: '새 문제 다시 받기',
          color: ButtonColor.surface,
        ),
        Grading() => const _WorkingSkeleton(label: '해설을 쓰고 있어요'),
        _ => const _WorkingSkeleton(label: '문제를 만들고 있어요'),
      },
      _ => null,
    };
  }
}

class _QuizStartView extends StatelessWidget {
  final VoidCallback onStart;

  const _QuizStartView({required this.onStart});

  static const _topics = [
    ('네트워크', Alignment(-0.75, -0.55), -0.08),
    ('운영체제', Alignment(0.75, -0.4), 0.06),
    ('자료구조', Alignment(-0.7, 0.45), 0.05),
    ('데이터베이스', Alignment(0.65, 0.6), -0.06),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          children: [
            Expanded(
              child: ClipRect(
                child: Stack(
                  children: [
                    Align(
                      alignment: const Alignment(-1.4, -0.6),
                      child: _Blob(
                        size: 220,
                        color: context.colors.primary.withAlpha(18),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.5, 0.7),
                      child: _Blob(
                        size: 240,
                        color: context.colors.tertiary.withAlpha(18),
                      ),
                    ),
                    for (final (main, alignment, angle) in _topics)
                      Align(
                        alignment: alignment,
                        child: Transform.rotate(
                          angle: angle,
                          child: _TopicChip(main: main),
                        ),
                      ),
                    Align(
                      alignment: const Alignment(0, -0.05),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.onSurface,
                              borderRadius: AppShape.pill,
                            ),
                            child: Text(
                              '오늘은 뭐부터 풀어볼까요?',
                              style: context.captionMedium.copyWith(
                                color: context.colors.surface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SvgPicture.asset(
                            'assets/mascot/mascot_happy.svg',
                            width: 110,
                            height: 110,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              '내 수준에 맞춘 문제를 AI가 바로 만들어 드려요',
              style: context.captionMedium.copyWith(
                color: context.colors.outline,
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              onPressed: onStart,
              text: '문제 받기',
              color: ButtonColor.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double size;
  final Color color;

  const _Blob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _TopicChip extends StatelessWidget {
  final String main;

  const _TopicChip({required this.main});

  @override
  Widget build(BuildContext context) {
    final style = MainCategoryStyle.of(context, main);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: style.surface,
        borderRadius: AppShape.pill,
        boxShadow: [
          BoxShadow(
            color: style.foreground.withAlpha(25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        main,
        style: context.captionMedium.copyWith(
          color: style.foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _HeaderLink extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderLink({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceContainerLowest,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: context.colors.primary),
        ),
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  final Quiz quiz;
  final bool enabled;
  final String? submittedAnswer;
  final bool showResult;
  final ValueChanged<String> onSubmit;

  const _QuizCard({
    required this.quiz,
    required this.enabled,
    required this.submittedAnswer,
    required this.showResult,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final code = quiz.codeSnippet;
    final imageUrl = quiz.imageUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (code != null) CodeBlock(language: code.language, code: code.code),
        if (imageUrl != null) ImageWidget(url: imageUrl),
        switch (quiz.quizContent) {
          SingleChoiceContent(:final options, :final correctIndex) =>
            QuizChoiceChip(
              key: ValueKey(quiz.qid),
              options: options,
              enabled: enabled,
              submittedAnswer: submittedAnswer,
              correctIndex: showResult ? correctIndex : null,
              onSubmit: onSubmit,
            ),
          ShortAnswerContent() => Text(
            enabled ? '아래 입력창에 답을 적어 주세요' : '답을 제출했어요',
            style: context.captionMedium.copyWith(
              color: context.colors.outline,
            ),
          ),
        },
      ],
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final Quiz quiz;
  final QuizFeedback feedback;
  final VoidCallback? onNext;
  final VoidCallback? onAnswerAgain;

  const _FeedbackCard({
    required this.quiz,
    required this.feedback,
    required this.onNext,
    required this.onAnswerAgain,
  });

  @override
  Widget build(BuildContext context) {
    if (feedback.isOffTopic) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          // AI가 규칙을 어기고 정답을 적어 와도 다시 풀 문제라 보여주지 않음
          Text(
            '문제에 대한 답을 적으면 바로 채점해 드려요.',
            style: context.textStyles.bodySmall,
          ),
          if (onAnswerAgain != null)
            PrimaryButton(
              onPressed: onAnswerAgain,
              text: '다시 답하기',
              color: ButtonColor.primary,
            ),
          if (onNext != null)
            PrimaryButton(
              onPressed: onNext,
              text: '다른 문제 받기',
              color: ButtonColor.surface,
            ),
        ],
      );
    }
    final code = feedback.codeSnippet;
    final imageUrl = feedback.imageUrl;
    final note = switch (quiz.quizContent) {
      _ when feedback.isCorrect => '',
      SingleChoiceContent(:final correctIndex) => '정답은 ${correctIndex + 1}번',
      ShortAnswerContent() => '',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnswerFeedback(
          answerResult: feedback.isCorrect
              ? AnswerResult.correct
              : AnswerResult.wrong,
          wrongAnswerNote: note,
          explanation: feedback.feedbackText,
          keyPoint: feedback.keyPoint,
          referenceAnswer:
              quiz.quizContent is ShortAnswerContent &&
                  quiz.referenceAnswer.isNotEmpty
              ? quiz.referenceAnswer
              : null,
        ),
        if (code != null) CodeBlock(language: code.language, code: code.code),
        if (imageUrl != null) ImageWidget(url: imageUrl),
        if (onNext != null) ...[
          const SizedBox(height: 12),
          PrimaryButton(
            onPressed: onNext,
            text: '다음 문제',
            color: ButtonColor.primary,
          ),
        ],
      ],
    );
  }
}

class _WorkingSkeleton extends StatelessWidget {
  final String label;

  const _WorkingSkeleton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const ShimmerWrapper(
              child: SkeletonBox(
                width: 72,
                height: 24,
                borderRadius: AppShape.pill,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: context.captionMedium.copyWith(
                color: context.colors.outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const ShimmerWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SkeletonLine(1),
              SizedBox(height: 8),
              _SkeletonLine(0.9),
              SizedBox(height: 8),
              _SkeletonLine(0.6),
              SizedBox(height: 14),
              SkeletonBox(
                width: double.infinity,
                height: 76,
                borderRadius: AppShape.widgetCard,
              ),
              SizedBox(height: 14),
              _SkeletonLine(0.75),
              SizedBox(height: 8),
              _SkeletonLine(0.45),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  final double widthFactor;

  const _SkeletonLine(this.widthFactor);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: const SkeletonBox(
        width: double.infinity,
        height: 12,
        borderRadius: AppShape.skeletonBar,
      ),
    );
  }
}

class _WorkingIndicator extends StatelessWidget {
  final String text;

  const _WorkingIndicator(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/mascot/mascot_think.svg',
          width: 64,
          height: 64,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLowest,
            borderRadius: AppShape.pill,
            border: Border.all(color: context.colors.primary.withAlpha(30)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '•••',
                style: context.captionMedium.copyWith(
                  color: context.colors.primary.withAlpha(120),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: context.captionMedium.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
