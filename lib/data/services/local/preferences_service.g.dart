// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
        isAutoDispose: true,
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
    r'2aa8022d1e08fed7e62a5e77f599bf2e5f0d9391';
