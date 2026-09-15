import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hontudy/presentation/core/theme/context_theme_extension.dart';
import 'package:hontudy/presentation/core/theme/text_type.dart';
import 'package:hontudy/presentation/views/component/divider_widget.dart';
import 'package:hontudy/presentation/views/component/recent_wrong_answer_section.dart';
import 'package:hontudy/presentation/views/component/topic_summary_card.dart';
import 'package:hontudy/presentation/views/route/bottom_nav_bar.dart';

class NoteSummaryPage extends StatefulWidget {
  const NoteSummaryPage({super.key});

  @override
  State<NoteSummaryPage> createState() => _NoteSummaryPageState();
}

class _NoteSummaryPageState extends State<NoteSummaryPage> {
  final savedQuiz = 14;
  final wrongAnswer = 9;
  final mainTopic = '네트워크';
  final secondaryTopic = '전송 계층';
  final currentFilter = '약한 순서';
  final List<List<dynamic>> wrongQuiz = [
    ['SO_REUSEADDR로 포트를 즉시 재사용하는 이유', 3],
    ['개방 주소법에서 클러스터링이 생기는 이유', 5],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
    ['은행원 알고리즘의 안전 상태 판단 기준', 7],
  ];

  @override
  Widget build(BuildContext context) {
    double circleIndicatorValue = ((savedQuiz - wrongAnswer) / savedQuiz)
        .toDouble();
    return Scaffold(
      extendBody: true,
      backgroundColor: context.colors.surface,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
          child: SafeArea(
            child: BottomNavBar(
              currentIndex: 1,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '노트',
              style: TextType.titleLarge.copyWith(letterSpacing: -0.5),
            ),
            Text(
              '주제별로 모인 $savedQuiz문제 · $currentFilter',
              style: context.captionMedium,
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: .fromHeight(1.0),
          child: DividerWidget(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                        '$mainTopic · $secondaryTopic',
                        style: TextType.titleSmall.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '$savedQuiz 문제 중 $wrongAnswer개 오답',
                        style: context.captionMedium.copyWith(
                          color: context.colors.onPrimary.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: circleIndicatorValue,
                          backgroundColor: context.colors.onPrimary.withAlpha(
                            50,
                          ),
                          color: context.colors.onPrimary,
                          strokeWidth: 6,
                        ),
                      ),
                      Text(
                        '${(circleIndicatorValue * 100).round()}%',
                        style: TextType.headlineSmall.copyWith(
                          color: context.colors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _TopicSummaryGrid(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
            for (var index = 0; index < wrongQuiz.length; index++) ...[
              RecentWrongAnswerSection(
                wrongQuiz: wrongQuiz[index][0],
                onTap: () {},
                  timeAgo: wrongQuiz[index][1],
              ),
              if (index != wrongQuiz.length - 1) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _TopicSummaryGrid extends StatefulWidget {
  const _TopicSummaryGrid({super.key});

  @override
  State<_TopicSummaryGrid> createState() => _TopicSummaryGridState();
}

class _TopicSummaryGridState extends State<_TopicSummaryGrid> {
  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> topics = [
      ['네트워크', 14, 9],
      ['자료구조', 9, 2],
      ['데이터베이스', 5, 1],
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        if (index > 2) {
          return TopicMoreCard(
            emptyTopic: 3,
            onTap: () {},
          );
        } else {
          final topic = topics[index];
          return TopicSummaryCard(
            topic: topic[0],
            savedQuiz: topic[1],
            wrongAnswer: topic[2],
            onDetail: () {},
          );
        }
      },
    );
  }
}
