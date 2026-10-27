// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportViewModel)
final reportViewModelProvider = ReportViewModelProvider._();

final class ReportViewModelProvider
    extends $AsyncNotifierProvider<ReportViewModel, void> {
  ReportViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportViewModelHash();

  @$internal
  @override
  ReportViewModel create() => ReportViewModel();
}

String _$reportViewModelHash() => r'1c903d09f5425c33c0e7d7ac857b5b52c0a4b473';

abstract class _$ReportViewModel extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
