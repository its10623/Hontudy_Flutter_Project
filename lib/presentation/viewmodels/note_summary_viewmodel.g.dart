// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_summary_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NoteSummaryViewModel)
final noteSummaryViewModelProvider = NoteSummaryViewModelProvider._();

final class NoteSummaryViewModelProvider
    extends $AsyncNotifierProvider<NoteSummaryViewModel, NoteSummary> {
  NoteSummaryViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noteSummaryViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noteSummaryViewModelHash();

  @$internal
  @override
  NoteSummaryViewModel create() => NoteSummaryViewModel();
}

String _$noteSummaryViewModelHash() =>
    r'9e681edce6392eff7e1fdb1f6077fcc0b5f137dd';

abstract class _$NoteSummaryViewModel extends $AsyncNotifier<NoteSummary> {
  FutureOr<NoteSummary> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NoteSummary>, NoteSummary>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NoteSummary>, NoteSummary>,
              AsyncValue<NoteSummary>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
