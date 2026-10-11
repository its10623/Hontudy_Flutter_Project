import 'package:hontudy/domain/models/solved_record.dart';
import 'package:hontudy/presentation/state/note_summary_state.dart';

class NoteDetail {
  final MainSummary? summary;
  final List<SolvedRecord> records;

  const NoteDetail({
    required this.summary,
    required this.records,
  });

  List<SolvedRecord> get wrongRecords =>
      records.where((record) => !record.quizFeedback.isCorrect).toList();

  List<SolvedRecord> get correctRecords =>
      records.where((record) => record.quizFeedback.isCorrect).toList();

  bool get isEmpty => records.isEmpty;

  /// [main]이 null이면 모든 주제의 기록을 모은다(틀린 문제 모아보기).
  factory NoteDetail.fromRecords(String? main, List<SolvedRecord> allRecords) {
    final mainRecords =
        allRecords
            .where(
              (record) => main == null || record.quiz.category.main == main,
            )
            .toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final summary = mainRecords.isEmpty
        ? null
        : MainSummary.fromRecords(main ?? '', mainRecords);

    return NoteDetail(
      summary: summary,
      records: mainRecords,
    );
  }
}
