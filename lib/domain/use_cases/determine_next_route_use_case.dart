import 'package:hontudy/domain/repositories/diagnosis_repository.dart';
import 'package:hontudy/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';

enum NextRoute { needsSignIn, needDiagnosis, needsTermsAgreement, ready }

class DetermineNextRouteUseCase {
  final UserRepository _userRepository;
  final DiagnosisRepository _diagnosisRepository;

  DetermineNextRouteUseCase({
    required this._userRepository,
    required this._diagnosisRepository,
  });

  Future<NextRoute> call() async {
    final user = _userRepository.currentUser;
    if (user == null) return NextRoute.needsSignIn;

    final hasAgreed = await _userRepository.fetchTermsAgreement().fold(
      (success) => success,
      (failure) => throw failure,
    );
    if (!hasAgreed) return NextRoute.needsTermsAgreement;

    final profile = await _diagnosisRepository.fetchDiagnosisProfile().fold(
      (success) => success.$1,
      (failure) => throw failure,
    );

    if (profile == null) return NextRoute.needDiagnosis;

    return NextRoute.ready;
  }
}
