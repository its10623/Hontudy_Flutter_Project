import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/state/note_summary_state.dart';
import 'package:hontudy/presentation/viewmodels/note_summary_viewmodel.dart';
import 'package:hontudy/presentation/views/component/app_background.dart';
import 'package:hontudy/presentation/views/component/note_status_views.dart';
import 'package:hontudy/presentation/views/pages/all_mains_page.dart';
import 'package:hontudy/presentation/views/pages/quiz_chat_page.dart';
import 'package:hontudy/presentation/views/component/recent_wrong_answer_section.dart';
import 'package:hontudy/presentation/views/component/shimmer_wrapper.dart';
import 'package:hontudy/presentation/views/component/skeleton_box.dart';
import 'package:hontudy/presentation/views/component/summary_card.dart';
import 'package:hontudy/presentation/views/route/bottom_nav_bar.dart';

import '../../core/format/days_ago.dart';

class NoteSummaryPage extends ConsumerWidget {
  const NoteSummaryPage({super.key});

  static const _sortLabel = '약한 순서';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryState = ref.watch(noteSummaryViewModelProvider);
    return AppBackground(
      child: Scaffold(
        extendBody: true,
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
                '노트',
                style: TextType.titleLarge.copyWith(letterSpacing: -0.5),
              ),
              Text(
                switch (summaryState) {
                  AsyncData(:final value) when value.isEmpty => '아직 푼 문제가 없어요',
                  AsyncData(:final value) =>
                    '주제별로 모인 ${value.totalCount}문제 · $_sortLabel',
                  AsyncError() => '불러오는 중 문제가 생겼어요',
                  _ => '',
                },
                style: context.captionMedium,
              ),
            ],
          ),
        ),
        body: switch (summaryState) {
          AsyncData(:final value) when value.isEmpty => NoteEmptyView(
            onStartQuiz: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const QuizChatPage()),
            ),
          ),
          AsyncData(:final value) => _NoteSummaryBody(summary: value),
          AsyncError() => NoteLoadErrorView(
            onRetry: () => ref.invalidate(noteSummaryViewModelProvider),
          ),
          _ => const _NoteSummarySkeleton(),
        },
      ),
    );
  }
}

class _MainSummaryGrid extends StatelessWidget {
  final List<MainSummary> mains;
  final VoidCallback onMore;
  final void Function(String main) onDetail;
  final List<String> unsolvedMains;

  const _MainSummaryGrid({
    required this.mains,
    required this.onMore,
    required this.onDetail,
    required this.unsolvedMains,
  });

  @override
  Widget build(BuildContext context) {
    final cells = mains
        .take(3)
        .map<_MainGridCell>(
          (mainSummary) => _SolvedMainCell(mainSummary: mainSummary),
        )
        .toList();
    final fillerMains = unsolvedMains.take(3 - cells.length).toList();
    final allMainCount = mains.length + unsolvedMains.length;
    cells.addAll(fillerMains.map((main) => _UnsolvedMainCell(main: main)));
    cells.add(
      _AllMainsCell(hiddenCount: allMainCount - cells.length),
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cells.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 140,
      ),
      itemBuilder: (context, index) {
        return switch (cells[index]) {
          _SolvedMainCell(:final mainSummary) => MainSummaryCard(
            onDetail: () => onDetail(mainSummary.main),
            summary: mainSummary,
          ),
          _UnsolvedMainCell(:final main) => UnsolvedMainCard(main: main),
          _AllMainsCell(:final hiddenCount) => AllMainsCard(
            hiddenCount: hiddenCount,
            onTap: onMore,
          ),
        };
      },
    );
  }
}

sealed class _MainGridCell {
  const _MainGridCell();
}

class _SolvedMainCell extends _MainGridCell {
  final MainSummary mainSummary;

  const _SolvedMainCell({required this.mainSummary});
}

class _UnsolvedMainCell extends _MainGridCell {
  final String main;

  const _UnsolvedMainCell({required this.main});
}

class _AllMainsCell extends _MainGridCell {
  final int hiddenCount;

  const _AllMainsCell({
    required this.hiddenCount,
  });
}

class _NoteSummaryBody extends StatelessWidget {
  final NoteSummary summary;

  const _NoteSummaryBody({
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final weakest = summary.weakest!;
    final weakestTopic = weakest.weakestTopic;
    final weakestTitle = weakestTopic == null
        ? weakest.main
        : '${weakest.main} · $weakestTopic';
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '가장 약한 주제',
                        style: context.captionMedium.copyWith(
                          color: context.colors.onPrimary.withAlpha(200),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        weakestTitle,
                        style: TextType.titleSmall.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '${weakest.solvedCount} 문제 중 ${weakest.wrongCount}개 오답',
                        style: context.captionMedium.copyWith(
                          color: context.colors.onPrimary.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        value: weakest.correctRate,
                        backgroundColor: context.colors.onPrimary.withAlpha(
                          50,
                        ),
                        color: context.colors.onPrimary,
                        strokeWidth: 6,
                      ),
                    ),
                    Text(
                      '${(weakest.correctRate * 100).round()}%',
                      style: TextType.headlineSmall.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _MainSummaryGrid(
            mains: summary.mains.skip(1).toList(),
            onMore: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AllMainsPage()),
            ),
            onDetail: (String s) {},
            unsolvedMains: summary.unsolvedMains,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '최근 틀린 문제',
                style: TextType.captionMedium,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '전체 보기',
                  style: TextType.captionMedium.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          for (
            var index = 0;
            index < summary.recentWrongRecords.length;
            index++
          ) ...[
            RecentWrongAnswerSection(
              wrongQuiz: summary.recentWrongRecords[index].quiz.questionText,
              onTap: () {},
              timeAgo: formatDaysAgo(
                summary.recentWrongRecords[index].timestamp,
              ),
            ),
            if (index != summary.recentWrongRecords.length - 1)
              const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _NoteSummarySkeleton extends StatelessWidget {
  const _NoteSummarySkeleton();

  static const _recentRowCount = 3;

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        children: [
          SkeletonBox(
            width: double.infinity,
            height: 96,
            borderRadius: BorderRadius.circular(16),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 140,
            children: [
              for (var i = 0; i < 4; i++)
                SkeletonBox(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: BorderRadius.circular(16),
                ),
            ],
          ),
          const SizedBox(height: 20),
          const SkeletonBox(width: 80, height: 14),
          const SizedBox(height: 16),
          for (var i = 0; i < _recentRowCount; i++) ...[
            SkeletonBox(
              width: double.infinity,
              height: 56,
              borderRadius: BorderRadius.circular(12),
            ),
            if (i != _recentRowCount - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
