import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/domain/models/quiz.dart';
import 'package:hontudy/domain/models/solved_record.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/format/days_ago.dart';
import 'package:hontudy/presentation/state/note_detail_state.dart';
import 'package:hontudy/presentation/viewmodels/note_detail_viewmodel.dart';
import 'package:hontudy/presentation/views/component/choice_chip_widget.dart';
import 'package:hontudy/presentation/views/component/genui/code_block.dart';
import 'package:hontudy/presentation/views/component/genui/image_widget.dart';
import 'package:hontudy/presentation/views/component/primary_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/theme/context_theme_extension.dart';
import '../../core/theme/text_type.dart';
import '../component/app_background.dart';
import '../component/chip_widget.dart';
import '../component/note_status_views.dart';
import '../component/shimmer_wrapper.dart';
import '../component/skeleton_box.dart';
import '../route/bottom_nav_bar.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class NoteDetailPage extends ConsumerStatefulWidget {
  final String main;
  final String? initialQid;

  const NoteDetailPage({
    super.key,
    required this.main,
    this.initialQid,
  });

  @override
  ConsumerState<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends ConsumerState<NoteDetailPage> {
  final PageController _controller = PageController(
    viewportFraction: 0.8,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(noteDetailViewModelProvider(widget.main));
    final summary = detailState.value?.summary;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: const SafeArea(
              child: BottomNavBar(
                currentIndex: 1,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.main,
                style: TextType.titleLarge.copyWith(letterSpacing: -0.5),
              ),
              if (summary case final s?)
                Text(
                  [
                    '${s.solvedCount}문제',
                    '오답 ${s.wrongCount}',
                    ?s.weakestTopic,
                  ].join(' · '),
                  style: context.captionMedium,
                ),
            ],
          ),
        ),
        body: switch (detailState) {
          AsyncData(:final value) when value.isEmpty =>
            const NoteDetailEmptyView(
              reason: NoteDetailEmptyReason.noRecords,
            ),
          AsyncData(:final value) => _NoteDetailBody(
            noteDetail: value,
            controller: _controller,
            initialQid: widget.initialQid,
          ),
          AsyncError() => NoteLoadErrorView(
            onRetry: () =>
                ref.invalidate(noteDetailViewModelProvider(widget.main)),
          ),
          _ => const _NoteDetailSkeleton(),
        },
      ),
    );
  }
}

enum _RecordFilter {
  all,
  wrong,
  correct,
}

class _NoteDetailBody extends StatefulWidget {
  final NoteDetail _noteDetail;
  final PageController _controller;
  final String? _initialQid;

  const _NoteDetailBody({
    required this._noteDetail,
    required this._controller,
    this._initialQid,
  });

  @override
  State<_NoteDetailBody> createState() => _NoteDetailBodyState();
}

class _NoteDetailBodyState extends State<_NoteDetailBody> {
  _RecordFilter _filter = _RecordFilter.all;

  @override
  void initState() {
    super.initState();
    _showInitialRecord();
  }

  void _showInitialRecord() {
    final qid = widget._initialQid;
    if (qid == null) return;

    final wrongIndex = widget._noteDetail.wrongRecords.indexWhere(
      (record) => record.quiz.qid == qid,
    );
    final index = wrongIndex != -1
        ? wrongIndex
        : widget._noteDetail.records.indexWhere(
            (record) => record.quiz.qid == qid,
          );
    if (index == -1) return;
    if (wrongIndex != -1) _filter = _RecordFilter.wrong;

    // PageView가 그려진 뒤에야 컨트롤러가 붙어서 첫 프레임 이후에 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget._controller.hasClients) {
        widget._controller.jumpToPage(index);
      }
    });
  }

  final Set<String> _checkedQids = {};

  @override
  Widget build(BuildContext context) {
    final records = switch (_filter) {
      _RecordFilter.all => widget._noteDetail.records,
      _RecordFilter.wrong => widget._noteDetail.wrongRecords,
      _RecordFilter.correct => widget._noteDetail.correctRecords,
    };
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChoiceChipWidget(
            selectedIndex: _filter.index,
            onSelected: (i) => setState(() {
              _filter = _RecordFilter.values[i];
              if (widget._controller.hasClients) {
                widget._controller.jumpToPage(0);
              }
            }),
            solvedCount: widget._noteDetail.summary?.solvedCount ?? 0,
            wrongCount: widget._noteDetail.summary?.wrongCount ?? 0,
          ),
          if (records.isNotEmpty) ...[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                ),
                child: _NoteQuizCardCarousel(
                  controller: widget._controller,
                  quizzes: records,
                  checkedQids: _checkedQids,
                  onCheckedChanged: (qid, checked) => setState(() {
                    checked ? _checkedQids.add(qid) : _checkedQids.remove(qid);
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SmoothPageIndicator(
                  controller: widget._controller,
                  count: records.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: context.colors.primary,
                  ),
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: NoteDetailEmptyView(
                reason: switch (_filter) {
                  _RecordFilter.wrong => NoteDetailEmptyReason.noWrong,
                  _RecordFilter.correct => NoteDetailEmptyReason.noCorrect,
                  _RecordFilter.all => NoteDetailEmptyReason.noRecords,
                },
                onShowAll: () => setState(() => _filter = _RecordFilter.all),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NoteQuizCardCarousel extends StatelessWidget {
  final List<SolvedRecord> quizzes;
  final PageController _controller;
  final Set<String> checkedQids;
  final void Function(String qid, bool checked) onCheckedChanged;

  const _NoteQuizCardCarousel({
    required this._controller,
    required this.quizzes,
    required this.checkedQids,
    required this.onCheckedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      clipBehavior: Clip.none,
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final record = quizzes[index];
        final qid = record.quiz.qid;
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double distance = 0;
            if (_controller.hasClients && _controller.position.haveDimensions) {
              distance = (_controller.page! - index).abs().clamp(0.0, 1.0);
            }
            final scale = 1 - (distance * 0.15);
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: _NoteQuizCard(
            key: ValueKey(qid),
            record: record,
            isChecked: checkedQids.contains(qid),
            onCheckedChanged: (checked) => onCheckedChanged(qid, checked),
          ),
        );
      },
    );
  }
}

class _NoteQuizCard extends StatefulWidget {
  final SolvedRecord record;
  final bool isChecked;
  final ValueChanged<bool> onCheckedChanged;

  const _NoteQuizCard({
    required this.isChecked,
    required this.onCheckedChanged,
    required this.record,
    super.key,
  });

  @override
  State<_NoteQuizCard> createState() => _NoteQuizCardState();
}

class _NoteQuizCardState extends State<_NoteQuizCard>
    with SingleTickerProviderStateMixin {
  static const double _flipDistance = 200;

  double _dragOffset = 0;

  late final AnimationController _snapController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  double _snapStart = 0;
  double _snapTarget = 0;

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  void _snapTo(double target) {
    _snapStart = _dragOffset;
    _snapTarget = target;
    _snapController.forward(from: 0).then((_) {
      setState(() => _dragOffset = target);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _snapController,
      builder: (context, child) {
        final offset = _snapController.isAnimating
            ? lerpDouble(_snapStart, _snapTarget, _snapController.value)!
            : _dragOffset;
        final angle = (offset / _flipDistance).clamp(-1.0, 1.0) * pi;
        final showingBack = angle.abs() > pi / 2;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(angle),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerLowest,
              borderRadius: AppShape.card,
              boxShadow: [
                BoxShadow(
                  color: context.colors.outline.withAlpha(150),
                  blurRadius: 30,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: showingBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateX(pi),
                    child: _buildBackContent(context),
                  )
                : _buildFrontContent(context),
          ),
        );
      },
    );
  }

  Widget _buildFrontContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChipWidget(label: widget.record.quiz.category.topic),
                      Text(
                        formatDaysAgo(widget.record.timestamp),
                        style: context.captionMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Q. ${widget.record.quiz.questionText}',
                  style: TextType.titleMedium,
                ),
                if (widget.record.quiz.codeSnippet case final code?)
                  CodeBlock(
                    language: code.language,
                    code: code.code,
                  ),
                if (widget.record.quiz.imageUrl case final image?)
                  ImageWidget(
                    url: image,
                  ),
                _MyAnswerSection(record: widget.record),
                /*const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    ChipWidget(
                      label: '오답 ${widget.record.quiz.}회',
                      backgroundColor: AppColors.wrongSurface,
                      textColor: AppColors.wrong,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ChipWidget(
                      label: '정답 ${widget.quizzes[5]}회',
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        PrimaryButton(
          onPressed: () => _snapTo(_flipDistance),
          text: '해설 다시 보기',
          color: ButtonColor.primary,
        ),
        Center(
          child: GestureDetector(
            onTap: () => widget.onCheckedChanged(!widget.isChecked),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: widget.isChecked,
                  onChanged: (value) => widget.onCheckedChanged(value ?? false),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(color: context.colors.outline, width: 1.5),
                ),
                Text(
                  '이 문제 다시 출제',
                  style: context.captionLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('해설', style: TextType.titleMedium),
                const SizedBox(height: 12),
                Text(
                  _referenceAnswerText(widget.record.quiz),
                  style: context.captionMedium,
                ),
                Text(
                  widget.record.quizFeedback.feedbackText,
                  style: context.captionMedium,
                ),
                if (widget.record.quizFeedback.codeSnippet case final code?)
                  CodeBlock(
                    language: code.language,
                    code: code.code,
                  ),
                if (widget.record.quizFeedback.imageUrl case final image?)
                  ImageWidget(
                    url: image,
                  ),
                if (widget.record.quizFeedback.keyPoint case final point?)
                  Text(
                    point,
                    style: context.captionMedium,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        PrimaryButton(
          onPressed: () => _snapTo(0),
          text: '문제로 돌아가기',
          color: ButtonColor.surface,
        ),
      ],
    );
  }
}

/// 객관식은 프롬프트 규칙상 reference_answer가 비어 있어서 정답 보기를 대신 보여줌
String _referenceAnswerText(Quiz quiz) => switch (quiz.quizContent) {
  SingleChoiceContent(:final options, :final correctIndex)
      when correctIndex >= 0 && correctIndex < options.length =>
    '${correctIndex + 1}. ${options[correctIndex]}',
  _ => quiz.referenceAnswer,
};

int? _selectedOptionIndex(List<String> options, String userAnswer) {
  final answer = userAnswer.trim();
  final byText = options.indexWhere((option) => option.trim() == answer);
  if (byText != -1) return byText;
  final byNumber = int.tryParse(answer);
  if (byNumber == null) return null;
  if (byNumber >= 0 && byNumber < options.length) return byNumber;
  return null;
}

class _MyAnswerSection extends StatelessWidget {
  final SolvedRecord record;

  const _MyAnswerSection({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.outlineVariant.withAlpha(100),
        borderRadius: AppShape.widgetCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '내 답',
            style: TextType.captionSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colors.outline,
            ),
          ),
          const SizedBox(height: 6),
          switch (record.quiz.quizContent) {
            ShortAnswerContent() => Text(
              record.userAnswer,
              style: TextType.captionMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colors.outline,
              ),
            ),
            SingleChoiceContent(:final options) => _ChoiceOptions(
              options: options,
              selectedIndex: _selectedOptionIndex(options, record.userAnswer),
              isCorrect: record.quizFeedback.isCorrect,
            ),
          },
        ],
      ),
    );
  }
}

class _ChoiceOptions extends StatelessWidget {
  final List<String> options;
  final int? selectedIndex;
  final bool isCorrect;

  const _ChoiceOptions({
    required this.options,
    required this.selectedIndex,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          _ChoiceOptionRow(
            number: i + 1,
            text: options[i],
            selected: i == selectedIndex,
            isCorrect: isCorrect,
          ),
          if (i != options.length - 1) const SizedBox(height: 6),
        ],
      ],
    );
  }
}

class _ChoiceOptionRow extends StatelessWidget {
  final int number;
  final String text;
  final bool selected;
  final bool isCorrect;

  const _ChoiceOptionRow({
    required this.number,
    required this.text,
    required this.selected,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = !selected
        ? (context.colors.surfaceContainerLowest, context.colors.outline)
        : isCorrect
        ? (AppColors.correctSurface, AppColors.correct)
        : (AppColors.wrongSurface, AppColors.wrong);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppShape.button,
        border: selected ? Border.all(color: foreground) : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number',
            style: TextType.captionMedium.copyWith(
              fontWeight: FontWeight.w800,
              color: foreground,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextType.captionMedium.copyWith(
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: foreground,
              ),
            ),
          ),
          if (selected) ...[
            const SizedBox(width: 6),
            Icon(
              isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
              size: 16,
              color: foreground,
            ),
          ],
        ],
      ),
    );
  }
}

class _NoteDetailSkeleton extends StatelessWidget {
  const _NoteDetailSkeleton();

  static const _chipWidths = [72.0, 72.0, 64.0];
  static const _viewportFraction = 0.8;
  static const _sideScale = 0.85;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWrapper(
            child: Row(
              children: [
                for (final width in _chipWidths) ...[
                  SkeletonBox(
                    width: width,
                    height: 34,
                    borderRadius: AppShape.pill,
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = constraints.maxWidth * _viewportFraction;
                  return SizedBox.expand(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        for (final side in [-1.0, 1.0])
                          Transform.translate(
                            offset: Offset(side * cardWidth, 0),
                            child: Transform.scale(
                              scale: _sideScale,
                              child: _SkeletonQuizCard(width: cardWidth),
                            ),
                          ),
                        _SkeletonQuizCard(width: cardWidth),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: ShimmerWrapper(
                child: SkeletonBox(
                  width: 44,
                  height: 6,
                  borderRadius: AppShape.pill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonQuizCard extends StatelessWidget {
  final double width;

  const _SkeletonQuizCard({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppShape.card,
      ),
      child: const ShimmerWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonBox(
                  width: 80,
                  height: 22,
                  borderRadius: AppShape.pill,
                ),
                SkeletonBox(width: 40, height: 12),
              ],
            ),
            SizedBox(height: 20),
            SkeletonBox(width: double.infinity, height: 16),
            SizedBox(height: 8),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: SkeletonBox(width: double.infinity, height: 16),
            ),
            SizedBox(height: 24),
            Expanded(
              child: SkeletonBox(
                width: double.infinity,
                height: double.infinity,
                borderRadius: AppShape.widgetCard,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
