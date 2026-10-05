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

@ProviderFor(aiFunctionsService)
final aiFunctionsServiceProvider = AiFunctionsServiceProvider._();

final class AiFunctionsServiceProvider
    extends
        $FunctionalProvider<
          AiFunctionsService,
          AiFunctionsService,
          AiFunctionsService
        >
    with $Provider<AiFunctionsService> {
  AiFunctionsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiFunctionsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiFunctionsServiceHash();

  @$internal
  @override
  $ProviderElement<AiFunctionsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiFunctionsService create(Ref ref) {
    return aiFunctionsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiFunctionsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiFunctionsService>(value),
    );
  }
}

String _$aiFunctionsServiceHash() =>
    r'6a6ce4b032ac9ccf77cb74618865946797572a16';
