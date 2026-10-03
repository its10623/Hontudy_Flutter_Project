import 'package:hontudy/di/repository_providers.dart';
import 'package:hontudy/domain/use_cases/determine_next_route_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../di/use_case_providers.dart';

part 'splash_viewmodel.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  @override
  FutureOr<NextRoute> build() async {
    final nextRoute = ref.watch(determineNextRouteUseCaseProvider).call();
    await Future.wait([
      nextRoute,
      Future.delayed(const Duration(milliseconds: 1500)),
    ]);

    final route = await nextRoute;
    if (route != NextRoute.needsTermsAgreement) return route;

    final result = await ref.read(userRepositoryProvider).signOut();
    result.fold(
      (success) => success,
      (failure) => throw failure,
    );
    return NextRoute.needsSignIn;
  }
}
