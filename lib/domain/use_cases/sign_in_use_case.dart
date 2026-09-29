import 'package:hontudy/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../models/user.dart';

class SignInUseCase {
  final UserRepository _userRepository;

  SignInUseCase({required this._userRepository});

  Future<({User user, bool needsTermsAgreement})> call({required AuthProvider provider,}) async {
    final result = await switch (provider) {
      AuthProvider.google => _userRepository.signInWithGoogle(),
      AuthProvider.apple => _userRepository.signInWithApple(),
    }.fold(
          (success) => success,
          (failure) => throw failure,
    );
    final hasAgreed = await _userRepository.fetchTermsAgreement().fold(
      (success) => success,
      (failure) => throw failure,
    );
    return (user: result.user, needsTermsAgreement: !hasAgreed);
  }
}
