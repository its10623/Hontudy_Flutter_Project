import 'package:hontudy/di/repository_providers.dart';
import 'package:hontudy/domain/models/report.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_viewmodel.g.dart';

@riverpod
class ReportViewModel extends _$ReportViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> submitReport(Report report) async {
    state = const AsyncLoading();
    final repo = ref.read(reportRepositoryProvider);
    final result = await repo.report(report);
    if (!ref.mounted) return;

    result.fold(
      (_) {
        state = const AsyncData(null);
      },
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
    );
  }
}
