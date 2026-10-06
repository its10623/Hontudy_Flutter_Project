import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/state/note_summary_state.dart';
import 'package:hontudy/presentation/views/component/main_icon_tile.dart';
import 'package:hontudy/presentation/views/component/progress_bar_widget.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class MainSummaryCard extends StatelessWidget {
  final VoidCallback onDetail;
  final MainSummary summary;

  const MainSummaryCard({
    super.key,
    required this.onDetail,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppShape.widgetCard,
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
        borderRadius: AppShape.widgetCard,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: context.colors.primary.withAlpha(30),
          highlightColor: context.colors.primary.withAlpha(50),
          borderRadius: AppShape.widgetCard,
          onTap: onDetail,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainIconTile(main: summary.main, size: 40),
                const Spacer(),
                Text(
                  summary.main,
                  style: TextType.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  '${summary.solvedCount} 문제 · 오답 ${summary.wrongCount}개',
                  style: context.captionMedium,
                ),
                const Spacer(),
                ProgressBarWidget(
                  value: summary.correctRate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AllMainsCard extends StatelessWidget {
  final int hiddenCount;
  final VoidCallback onTap;

  const AllMainsCard({
    super.key,
    required this.hiddenCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppShape.widgetCard,
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
        borderRadius: AppShape.widgetCard,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: context.colors.primary.withAlpha(30),
          highlightColor: context.colors.primary.withAlpha(50),
          borderRadius: AppShape.widgetCard,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hiddenCount > 0)
                  Text(
                    '+$hiddenCount',
                    style: TextType.displayLarge.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                Text(
                  '전체 주제 보기',
                  style: TextType.headlineLarge.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UnsolvedMainCard extends StatelessWidget {
  final String main;

  const UnsolvedMainCard({super.key, required this.main});

  @override
  Widget build(BuildContext context) {
    final mutedColor = context.colors.onSurfaceVariant;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest.withAlpha(150),
        borderRadius: AppShape.widgetCard,
        border: Border.all(color: context.colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainIconTile(main: main, muted: true, size: 40),
            const Spacer(),
            Text(
              main,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextType.bodyLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: mutedColor,
              ),
            ),
            const Spacer(),
            Text(
              '아직 풀지 않았어요',
              style: context.captionMedium.copyWith(color: mutedColor),
            ),
            const Spacer(),
            const ProgressBarWidget(value: 0),
          ],
        ),
      ),
    );
  }
}
