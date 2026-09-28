// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authService)
final authServiceProvider = AuthServiceProvider._();

final class AuthServiceProvider
    extends $FunctionalProvider<AuthService, AuthService, AuthService>
    with $Provider<AuthService> {
  AuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authServiceHash();

  @$internal
  @override
  $ProviderElement<AuthService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthService create(Ref ref) {
    return authService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthService>(value),
    );
  }
}

String _$authServiceHash() => r'4ec7dd3409b1adcbac86a9f89ced41827be98ba8';

@ProviderFor(firestoreService)
final firestoreServiceProvider = FirestoreServiceProvider._();

final class FirestoreServiceProvider
    extends
        $FunctionalProvider<
          FirestoreService,
          FirestoreService,
          FirestoreService
        >
    with $Provider<FirestoreService> {
  FirestoreServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firestoreServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firestoreServiceHash();

  @$internal
  @override
  $ProviderElement<FirestoreService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirestoreService create(Ref ref) {
    return firestoreService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirestoreService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirestoreService>(value),
    );
  }
}

String _$firestoreServiceHash() => r'60ff847ea870b353b433504c7f164ea13f87009a';

@ProviderFor(llmService)
final llmServiceProvider = LlmServiceProvider._();

final class LlmServiceProvider
    extends $FunctionalProvider<LlmService, LlmService, LlmService>
    with $Provider<LlmService> {
  LlmServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'llmServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$llmServiceHash();

  @$internal
  @override
  $ProviderElement<LlmService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LlmService create(Ref ref) {
    return llmService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LlmService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LlmService>(value),
    );
  }
}

String _$llmServiceHash() => r'7673ffcf4ade6d1a391a0cf5b84ccc30225b8b50';
