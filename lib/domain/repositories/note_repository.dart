import 'package:result_dart/result_dart.dart';

import '../models/solved_record.dart';

enum NoteFilter { all, correctOnly, wrongOnly }

abstract class NoteRepository {
  AsyncResult<void> saveSolvedRecord(SolvedRecord record);
  AsyncResult<List<SolvedRecord>> fetchRecentSolvedRecords(int days);
  AsyncResult<List<SolvedRecord>> fetchSolvedRecords({
    required NoteFilter filter,
    int? limit,
  });
}
