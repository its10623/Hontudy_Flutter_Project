import 'package:hontudy/di/repository_providers.dart';
import 'package:hontudy/domain/repositories/note_repository.dart';
import 'package:hontudy/presentation/state/note_detail_state.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_detail_viewmodel.g.dart';

@riverpod
class NoteDetailViewModel extends _$NoteDetailViewModel {
  @override
  FutureOr<NoteDetail> build(String main) async {
    final records = await ref
        .watch(noteRepositoryProvider)
        .fetchSolvedRecords(filter: NoteFilter.all)
        .fold(
          (success) => success,
          (failure) => throw failure,
        );
    return NoteDetail.fromRecords(main, records);
  }
}
