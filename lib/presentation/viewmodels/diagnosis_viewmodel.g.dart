// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DiagnosisViewModel)
final diagnosisViewModelProvider = DiagnosisViewModelProvider._();

final class DiagnosisViewModelProvider
    extends $NotifierProvider<DiagnosisViewModel, DiagnosisState> {
  DiagnosisViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diagnosisViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diagnosisViewModelHash();

  @$internal
  @override
  DiagnosisViewModel create() => DiagnosisViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiagnosisState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiagnosisState>(value),
    );
  }
}

String _$diagnosisViewModelHash() =>
    r'621bbdad1fac72629fc00f5e309d148d4735c0de';

abstract class _$DiagnosisViewModel extends $Notifier<DiagnosisState> {
  DiagnosisState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DiagnosisState, DiagnosisState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DiagnosisState, DiagnosisState>,
              DiagnosisState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
