import 'package:hontudy/domain/exceptions.dart';
import 'package:hontudy/domain/use_cases/determine_next_route_use_case.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../di/repository_providers.dart';
import '../../di/use_case_providers.dart';
import '../../domain/models/user.dart';

part 'sign_in_viewmodel.g.dart';

@riverpod
class SignInViewModel extends _$SignInViewModel {
  @override
  FutureOr<NextRoute?> build() => null;

  Future<void> signIn(AuthProvider authProvider) async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      final repo = ref.read(userRepositoryProvider);
      switch (authProvider) {
        case AuthProvider.google:
          await repo.signInWithGoogle().fold(
            (success) => success,
            (failure) => throw failure,
          );
        case AuthProvider.apple:
          await repo.signInWithApple().fold(
            (success) => success,
            (failure) => throw failure,
          );
      }
      return await ref.read(determineNextRouteUseCaseProvider).call();
    });
    if (!ref.mounted) return;
    if (newState.error is SignInCancelledException) {
      state = const AsyncData(null);
    } else {
      state = newState;
    }
  }

  Future<void> agreeToTerms() async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      final repo = ref.read(userRepositoryProvider);
      final result = await repo.saveTermsAgreement();
      result.fold(
        (success) => success,
        (failure) => throw failure,
      );
      return await ref.read(determineNextRouteUseCaseProvider).call();
    });
    if (!ref.mounted) return;
    state = newState;
  }

  Future<void> disagreeToTerms() async {
    final newState = await AsyncValue.guard(() async {
      final repo = ref.read(userRepositoryProvider);
      final result = await repo.signOut();
      result.fold(
        (success) => success,
        (failure) => throw failure,
      );
      return await ref.read(determineNextRouteUseCaseProvider).call();
    });
    if (!ref.mounted) return;
    state = newState;
  }
}
