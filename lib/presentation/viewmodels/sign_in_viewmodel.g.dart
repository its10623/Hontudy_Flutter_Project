// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignInViewModel)
final signInViewModelProvider = SignInViewModelProvider._();

final class SignInViewModelProvider
    extends $AsyncNotifierProvider<SignInViewModel, NextRoute?> {
  SignInViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInViewModelHash();

  @$internal
  @override
  SignInViewModel create() => SignInViewModel();
}

String _$signInViewModelHash() => r'47ba7f574506e8fd1447c9e40aac79dd1fbb86c5';

abstract class _$SignInViewModel extends $AsyncNotifier<NextRoute?> {
  FutureOr<NextRoute?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NextRoute?>, NextRoute?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NextRoute?>, NextRoute?>,
              AsyncValue<NextRoute?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
