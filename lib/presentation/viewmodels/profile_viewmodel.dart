import 'package:hontudy/di/repository_providers.dart';
import 'package:hontudy/di/use_case_providers.dart';
import 'package:hontudy/presentation/state/profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_viewmodel.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  @override
  FutureOr<ProfileState> build() async {
    final (
      diagnosis,
    ) = (await ref.watch(diagnosisRepositoryProvider).fetchDiagnosisProfile())
        .getOrThrow();
    return ProfileState(
      user: ref.watch(userRepositoryProvider).currentUser,
      diagnosis: diagnosis,
    );
  }

  Future<void> signOut() async {
    (await ref.read(userRepositoryProvider).signOut()).getOrThrow();
  }

  Future<void> forgetDiagnosis() async {
    (await ref.read(diagnosisRepositoryProvider).deleteDiagnosisProfile())
        .getOrThrow();
  }

  Future<void> deleteAccount() async {
    await ref.read(deleteAccountUseCaseProvider).call();
  }
}
