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
        isAutoDispose: false,
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

String _$authServiceHash() => r'00110bb31fe2c06cacd005f761b7c43770fc13c5';

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
        isAutoDispose: false,
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

String _$firestoreServiceHash() => r'64bb5d50049dc65279aa722f222743756f003e68';

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
        isAutoDispose: false,
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
    r'e3da1f6614e50d772eaa24186a59b3068a9f35d4';

@ProviderFor(preferencesService)
final preferencesServiceProvider = PreferencesServiceProvider._();

final class PreferencesServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<PreferenceService>,
          PreferenceService,
          FutureOr<PreferenceService>
        >
    with
        $FutureModifier<PreferenceService>,
        $FutureProvider<PreferenceService> {
  PreferencesServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesServiceHash();

  @$internal
  @override
  $FutureProviderElement<PreferenceService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PreferenceService> create(Ref ref) {
    return preferencesService(ref);
  }
}

String _$preferencesServiceHash() =>
    r'2cbf48212cf2e58d1ddfb1780d08e7493a53ec48';

@ProviderFor(appInfoService)
final appInfoServiceProvider = AppInfoServiceProvider._();

final class AppInfoServiceProvider
    extends $FunctionalProvider<AppInfoService, AppInfoService, AppInfoService>
    with $Provider<AppInfoService> {
  AppInfoServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInfoServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInfoServiceHash();

  @$internal
  @override
  $ProviderElement<AppInfoService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppInfoService create(Ref ref) {
    return appInfoService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppInfoService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppInfoService>(value),
    );
  }
}

String _$appInfoServiceHash() => r'85dd5bd3e1baa05e6dddba68933800c3eca11208';

@ProviderFor(emailService)
final emailServiceProvider = EmailServiceProvider._();

final class EmailServiceProvider
    extends $FunctionalProvider<EmailService, EmailService, EmailService>
    with $Provider<EmailService> {
  EmailServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailServiceHash();

  @$internal
  @override
  $ProviderElement<EmailService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmailService create(Ref ref) {
    return emailService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailService>(value),
    );
  }
}

String _$emailServiceHash() => r'7263cab1c16c34e093b59abd2b84351f9ad3b886';

@ProviderFor(deviceInfoService)
final deviceInfoServiceProvider = DeviceInfoServiceProvider._();

final class DeviceInfoServiceProvider
    extends
        $FunctionalProvider<
          DeviceInfoService,
          DeviceInfoService,
          DeviceInfoService
        >
    with $Provider<DeviceInfoService> {
  DeviceInfoServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceInfoServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceInfoServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceInfoService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceInfoService create(Ref ref) {
    return deviceInfoService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceInfoService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceInfoService>(value),
    );
  }
}

String _$deviceInfoServiceHash() => r'f1b68c968366fbc5fdec5c4b9e9f5b0fd2d4ad09';
