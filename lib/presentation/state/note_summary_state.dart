import 'package:hontudy/domain/models/category_scheme.dart';
import 'package:hontudy/domain/models/solved_record.dart';

class MainSummary {
  final String main;
  final int solvedCount;
  final int wrongCount;
  final String? weakestTopic;
  final DateTime lastSolvedAt;

  const MainSummary({
    required this.main,
    required this.solvedCount,
    required this.wrongCount,
    required this.weakestTopic,
    required this.lastSolvedAt,
  });

  double get correctRate =>
      solvedCount == 0 ? 0 : (solvedCount - wrongCount) / solvedCount;
}

enum MainSort { weakest, recent, name }

class NoteSummary {
  static const _recentWrongLimit = 5;

  final int totalCount;
  final List<MainSummary> mains;
  final List<SolvedRecord> recentWrongRecords;
  final List<String> unsolvedMains;

  const NoteSummary({
    required this.totalCount,
    required this.mains,
    required this.recentWrongRecords,
    required this.unsolvedMains,
  });

  bool get isEmpty => totalCount == 0;

  MainSummary? get weakest => mains.isEmpty ? null : mains.first;

  /// [mains]는 이미 약한 순서라서 weakest는 그대로 돌려준다.
  List<MainSummary> sortedMains(MainSort sort) => switch (sort) {
    MainSort.weakest => mains,
    MainSort.recent => [
      ...mains,
    ]..sort((a, b) => b.lastSolvedAt.compareTo(a.lastSolvedAt)),
    MainSort.name => [...mains]..sort((a, b) => a.main.compareTo(b.main)),
  };

  factory NoteSummary.fromRecords(List<SolvedRecord> records) {
    final recordsByMain = <String, List<SolvedRecord>>{};
    for (final record in records) {
      recordsByMain
          .putIfAbsent(record.quiz.category.main, () => [])
          .add(record);
    }

    final List<String> unsolvedMains = [];
    for (var category in CategoryScheme.mainCategories) {
      if (!recordsByMain.containsKey(category.name)) {
        unsolvedMains.add(category.name);
      }
    }

    final mains =
        recordsByMain.entries
            .map((entry) => _summarize(entry.key, entry.value))
            .toList()
          ..sort((a, b) {
            final byWrong = b.wrongCount.compareTo(a.wrongCount);
            if (byWrong != 0) return byWrong;
            return a.correctRate.compareTo(b.correctRate);
          });

    final recentWrong =
        records.where((record) => !record.quizFeedback.isCorrect).toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return NoteSummary(
      totalCount: records.length,
      mains: mains,
      recentWrongRecords: recentWrong.take(_recentWrongLimit).toList(),
      unsolvedMains: unsolvedMains,
    );
  }

  static MainSummary _summarize(String main, List<SolvedRecord> records) {
    final wrongCountByTopic = <String, int>{};
    for (final record in records) {
      if (record.quizFeedback.isCorrect) continue;
      wrongCountByTopic.update(
        record.quiz.category.topic,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }

    var lastSolvedAt = records.first.timestamp;
    for (final record in records) {
      if (record.timestamp.isAfter(lastSolvedAt)) {
        lastSolvedAt = record.timestamp;
      }
    }

    String? weakestTopic;
    var maxWrong = 0;
    wrongCountByTopic.forEach((topic, count) {
      if (count > maxWrong) {
        maxWrong = count;
        weakestTopic = topic;
      }
    });

    return MainSummary(
      main: main,
      solvedCount: records.length,
      wrongCount: wrongCountByTopic.values.fold(0, (sum, count) => sum + count),
      weakestTopic: weakestTopic,
      lastSolvedAt: lastSolvedAt,
    );
  }
}
