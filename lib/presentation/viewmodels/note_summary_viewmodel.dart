import 'package:hontudy/di/repository_providers.dart';
import 'package:hontudy/domain/repositories/note_repository.dart';
import 'package:hontudy/presentation/state/note_summary_state.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_summary_viewmodel.g.dart';

@riverpod
class NoteSummaryViewModel extends _$NoteSummaryViewModel {
  @override
  FutureOr<NoteSummary> build() async {
    final records = await ref
        .watch(noteRepositoryProvider)
        .fetchSolvedRecords(filter: NoteFilter.all)
        .fold(
          (success) => success,
          (failure) => throw failure,
        );
    return NoteSummary.fromRecords(records);
  }
}
