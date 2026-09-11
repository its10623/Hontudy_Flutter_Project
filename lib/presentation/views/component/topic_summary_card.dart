import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/progress_bar_widget.dart';

class TopicSummaryCard extends StatefulWidget {
  final String topic;
  final int savedQuiz;
  final int wrongAnswer;
  final VoidCallback onDetail;

  const TopicSummaryCard({
    super.key,
    required this.topic,
    required this.savedQuiz,
    required this.wrongAnswer,
    required this.onDetail,
  });

  @override
  State<TopicSummaryCard> createState() => _TopicSummaryCardState();
}

class _TopicSummaryCardState extends State<TopicSummaryCard> {
  @override
  Widget build(BuildContext context) {
    final parseValue =
        ((widget.savedQuiz - widget.wrongAnswer) / widget.savedQuiz);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.colors.outline.withAlpha(50),
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: context.colors.primary.withAlpha(30),
          highlightColor: context.colors.primary.withAlpha(50),
          borderRadius: BorderRadius.circular(16),
          onTap: widget.onDetail,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Placeholder(),
                ),
                Spacer(),
                Text(
                  widget.topic,
                  style: TextType.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.savedQuiz} 문제 · 오답 ${widget.wrongAnswer}개',
                  style: context.captionMedium,
                ),
                Spacer(),
                ProgressBarWidget(
                  value: parseValue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopicMoreCard extends StatefulWidget {
  final int emptyTopic;
  final VoidCallback onTap;

  const TopicMoreCard({
    super.key,
    required this.emptyTopic,
    required this.onTap,
  });

  @override
  State<TopicMoreCard> createState() => _TopicMoreCardState();
}

class _TopicMoreCardState extends State<TopicMoreCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.colors.outline.withAlpha(50),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: context.colors.outlineVariant,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: context.colors.primary.withAlpha(30),
          highlightColor: context.colors.primary.withAlpha(50),
          borderRadius: BorderRadius.circular(16),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  '아직 풀지않은',
                  style: TextType.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '주제 ${widget.emptyTopic}개',
                  style: TextType.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  '자세히 보기',
                  style: TextType.captionLarge.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
