import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/presentation/core/theme/app_colors.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/state/note_summary_state.dart';
import 'package:hontudy/presentation/viewmodels/note_summary_viewmodel.dart';
import 'package:hontudy/presentation/views/component/app_background.dart';
import 'package:hontudy/presentation/views/component/dashed_rrect_painter.dart';
import 'package:hontudy/presentation/views/component/filter_chip_widget.dart';
import 'package:hontudy/presentation/views/component/main_icon_tile.dart';
import 'package:hontudy/presentation/views/component/note_status_views.dart';
import 'package:hontudy/presentation/views/component/progress_bar_widget.dart';
import 'package:hontudy/presentation/views/pages/note_detail_page.dart';
import 'package:hontudy/presentation/core/theme/shape.dart';

class AllMainsPage extends ConsumerStatefulWidget {
  const AllMainsPage({super.key});

  @override
  ConsumerState<AllMainsPage> createState() => _AllMainsPageState();
}

class _AllMainsPageState extends ConsumerState<AllMainsPage> {
  static const _sortLabels = {
    MainSort.weakest: '약한 순',
    MainSort.recent: '최근 순',
    MainSort.name: '이름 순',
  };

  MainSort _sort = MainSort.weakest;

  @override
  Widget build(BuildContext context) {
    final summaryState = ref.watch(noteSummaryViewModelProvider);
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '전체 주제',
                style: TextType.titleMedium.copyWith(letterSpacing: -0.4),
              ),
              Text(
                switch (summaryState) {
                  AsyncData(:final value) =>
                    '푼 주제 ${value.mains.length}개 · ${value.totalCount}문제',
                  _ => '',
                },
                style: context.captionMedium,
              ),
            ],
          ),
        ),
        body: switch (summaryState) {
          AsyncData(:final value) => _buildBody(value),
          AsyncError() => NoteLoadErrorView(
            onRetry: () => ref.invalidate(noteSummaryViewModelProvider),
          ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }

  Widget _buildBody(NoteSummary summary) {
    final weakest = summary.weakest;
    final weakestMain = weakest != null && weakest.wrongCount > 0
        ? weakest.main
        : null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        Row(
          children: [
            for (final sort in MainSort.values) ...[
              FilterChipWidget(
                label: Text(_sortLabels[sort]!),
                isSelected: _sort == sort,
                onSelected: (_) => setState(() => _sort = sort),
              ),
              const SizedBox(width: 8),
            ],
          ],
        ),
        const SizedBox(height: 12),
        for (final mainSummary in summary.sortedMains(_sort)) ...[
          _SolvedMainRow(
            summary: mainSummary,
            isWeakest: mainSummary.main == weakestMain,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NoteDetailPage(main: mainSummary.main),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (summary.unsolvedMains.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
            child: Text(
              '아직 안 푼 주제',
              style: context.captionMedium.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          for (final main in summary.unsolvedMains) ...[
            _UnsolvedMainRow(main: main),
            const SizedBox(height: 10),
          ],
        ],
      ],
    );
  }
}

class _SolvedMainRow extends StatelessWidget {
  static const _lowRate = 0.5;

  final MainSummary summary;
  final bool isWeakest;
  final VoidCallback onTap;

  const _SolvedMainRow({
    required this.summary,
    required this.isWeakest,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLow = summary.correctRate < _lowRate;
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppShape.card,
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withAlpha(18),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppShape.card,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: context.colors.primary.withAlpha(30),
          highlightColor: context.colors.primary.withAlpha(50),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                MainIconTile(main: summary.main),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              summary.main,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextType.bodyLarge.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          if (isWeakest) ...[
                            const SizedBox(width: 6),
                            const _WeakBadge(),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      ProgressBarWidget(
                        value: summary.correctRate,
                        color: isLow ? AppColors.quiz : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(summary.correctRate * 100).round()}%',
                      style: TextType.bodySmall.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isLow ? AppColors.metadata : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${summary.solvedCount}문제 · 오답 ${summary.wrongCount}',
                      style: context.captionSmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeakBadge extends StatelessWidget {
  const _WeakBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: const BoxDecoration(
        color: AppColors.metadataSurface,
        borderRadius: AppShape.pill,
      ),
      child: Text(
        '약점',
        style: TextType.captionSmall.copyWith(
          fontWeight: FontWeight.w800,
          color: AppColors.metadata,
        ),
      ),
    );
  }
}

class _UnsolvedMainRow extends StatelessWidget {
  final String main;

  const _UnsolvedMainRow({required this.main});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: DashedRRectPainter(
        color: context.colors.outlineVariant,
        radius: 20,
        strokeWidth: 1.5,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            MainIconTile(main: main, muted: true),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                main,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextType.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colors.onSurfaceVariant.withAlpha(150),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
