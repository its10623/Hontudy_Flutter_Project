// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_case_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(requestQuizUseCase)
final requestQuizUseCaseProvider = RequestQuizUseCaseProvider._();

final class RequestQuizUseCaseProvider
    extends
        $FunctionalProvider<
          RequestQuizUseCase,
          RequestQuizUseCase,
          RequestQuizUseCase
        >
    with $Provider<RequestQuizUseCase> {
  RequestQuizUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestQuizUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestQuizUseCaseHash();

  @$internal
  @override
  $ProviderElement<RequestQuizUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RequestQuizUseCase create(Ref ref) {
    return requestQuizUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RequestQuizUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RequestQuizUseCase>(value),
    );
  }
}

String _$requestQuizUseCaseHash() =>
    r'6277c6833ffc7a87f0947c3f8eb302a8dedf045d';

@ProviderFor(submitQuizAnswerUseCase)
final submitQuizAnswerUseCaseProvider = SubmitQuizAnswerUseCaseProvider._();

final class SubmitQuizAnswerUseCaseProvider
    extends
        $FunctionalProvider<
          SubmitQuizAnswerUseCase,
          SubmitQuizAnswerUseCase,
          SubmitQuizAnswerUseCase
        >
    with $Provider<SubmitQuizAnswerUseCase> {
  SubmitQuizAnswerUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitQuizAnswerUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitQuizAnswerUseCaseHash();

  @$internal
  @override
  $ProviderElement<SubmitQuizAnswerUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubmitQuizAnswerUseCase create(Ref ref) {
    return submitQuizAnswerUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubmitQuizAnswerUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubmitQuizAnswerUseCase>(value),
    );
  }
}

String _$submitQuizAnswerUseCaseHash() =>
    r'a94918121ec0c55266d7ee3d263289239d6a07f4';

@ProviderFor(deleteAccountUseCase)
final deleteAccountUseCaseProvider = DeleteAccountUseCaseProvider._();

final class DeleteAccountUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteAccountUseCase,
          DeleteAccountUseCase,
          DeleteAccountUseCase
        >
    with $Provider<DeleteAccountUseCase> {
  DeleteAccountUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAccountUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteAccountUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteAccountUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteAccountUseCase create(Ref ref) {
    return deleteAccountUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteAccountUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteAccountUseCase>(value),
    );
  }
}

String _$deleteAccountUseCaseHash() =>
    r'54d620a72199e4d6a155d437015bc20310108671';

@ProviderFor(signInUseCase)
final signInUseCaseProvider = SignInUseCaseProvider._();

final class SignInUseCaseProvider
    extends $FunctionalProvider<SignInUseCase, SignInUseCase, SignInUseCase>
    with $Provider<SignInUseCase> {
  SignInUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignInUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignInUseCase create(Ref ref) {
    return signInUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInUseCase>(value),
    );
  }
}

String _$signInUseCaseHash() => r'd58e8797473f839b8f9a53642dc6628c6da636cc';
