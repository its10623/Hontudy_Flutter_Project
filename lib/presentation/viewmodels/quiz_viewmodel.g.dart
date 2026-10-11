// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QuizViewModel)
final quizViewModelProvider = QuizViewModelFamily._();

final class QuizViewModelProvider
    extends $NotifierProvider<QuizViewModel, QuizState> {
  QuizViewModelProvider._({
    required QuizViewModelFamily super.from,
    required DiagnosisProfile? super.argument,
  }) : super(
         retry: null,
         name: r'quizViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quizViewModelHash();

  @override
  String toString() {
    return r'quizViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  QuizViewModel create() => QuizViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuizState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuizState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is QuizViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quizViewModelHash() => r'436da5c4b2eb9780e016aa39996f5c7dc90f3032';

final class QuizViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          QuizViewModel,
          QuizState,
          QuizState,
          QuizState,
          DiagnosisProfile?
        > {
  QuizViewModelFamily._()
    : super(
        retry: null,
        name: r'quizViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuizViewModelProvider call(DiagnosisProfile? profile) =>
      QuizViewModelProvider._(argument: profile, from: this);

  @override
  String toString() => r'quizViewModelProvider';
}

abstract class _$QuizViewModel extends $Notifier<QuizState> {
  late final _$args = ref.$arg as DiagnosisProfile?;
  DiagnosisProfile? get profile => _$args;

  QuizState build(DiagnosisProfile? profile);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<QuizState, QuizState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QuizState, QuizState>,
              QuizState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
