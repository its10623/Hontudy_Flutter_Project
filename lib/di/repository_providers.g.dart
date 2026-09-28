// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userRepository)
final userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider
    extends $FunctionalProvider<UserRepository, UserRepository, UserRepository>
    with $Provider<UserRepository> {
  UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'a1600bfd2f6a269587d6ca59502354f29cbc6421';

@ProviderFor(diagnosisRepository)
final diagnosisRepositoryProvider = DiagnosisRepositoryProvider._();

final class DiagnosisRepositoryProvider
    extends
        $FunctionalProvider<
          DiagnosisRepository,
          DiagnosisRepository,
          DiagnosisRepository
        >
    with $Provider<DiagnosisRepository> {
  DiagnosisRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diagnosisRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diagnosisRepositoryHash();

  @$internal
  @override
  $ProviderElement<DiagnosisRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DiagnosisRepository create(Ref ref) {
    return diagnosisRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiagnosisRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiagnosisRepository>(value),
    );
  }
}

String _$diagnosisRepositoryHash() =>
    r'2bcd5b7c622e5a8d3e5a982e613bf0feb9a5c46a';

@ProviderFor(quizRepository)
final quizRepositoryProvider = QuizRepositoryProvider._();

final class QuizRepositoryProvider
    extends $FunctionalProvider<QuizRepository, QuizRepository, QuizRepository>
    with $Provider<QuizRepository> {
  QuizRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuizRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QuizRepository create(Ref ref) {
    return quizRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuizRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuizRepository>(value),
    );
  }
}

String _$quizRepositoryHash() => r'9814715f331be2d44f822949d1c5afe8806c55de';

@ProviderFor(noteRepository)
final noteRepositoryProvider = NoteRepositoryProvider._();

final class NoteRepositoryProvider
    extends $FunctionalProvider<NoteRepository, NoteRepository, NoteRepository>
    with $Provider<NoteRepository> {
  NoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noteRepositoryHash();

  @$internal
  @override
  $ProviderElement<NoteRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NoteRepository create(Ref ref) {
    return noteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NoteRepository>(value),
    );
  }
}

String _$noteRepositoryHash() => r'5ae2af485d181f23a437a77b441e6dcdbe226c61';
