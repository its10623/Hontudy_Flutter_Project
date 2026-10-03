// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SplashViewModel)
final splashViewModelProvider = SplashViewModelProvider._();

final class SplashViewModelProvider
    extends $AsyncNotifierProvider<SplashViewModel, NextRoute> {
  SplashViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splashViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splashViewModelHash();

  @$internal
  @override
  SplashViewModel create() => SplashViewModel();
}

String _$splashViewModelHash() => r'd879909a30cf14e61c62e533e178ab6e7ca36a41';

abstract class _$SplashViewModel extends $AsyncNotifier<NextRoute> {
  FutureOr<NextRoute> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NextRoute>, NextRoute>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NextRoute>, NextRoute>,
              AsyncValue<NextRoute>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
