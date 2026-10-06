import 'package:hontudy/domain/models/user.dart';
import 'package:hontudy/domain/repositories/diagnosis_repository.dart';
import 'package:hontudy/domain/repositories/user_repository.dart';

import '../repositories/note_repository.dart';

class DeleteAccountUseCase {
  final UserRepository _userRepository;
  final DiagnosisRepository _diagnosisRepository;
  final NoteRepository _noteRepository;

  DeleteAccountUseCase({
    required this._userRepository,
    required this._diagnosisRepository,
    required this._noteRepository,
  });

  /// 재인증 → 데이터 삭제 → (Apple) 연결 해제 → 계정 삭제 순서.
  Future<void> call() async {
    final user = _userRepository.currentUser;
    if (user == null) {
      throw StateError('로그인된 사용자가 없어 탈퇴할 수 없음');
    }

    String? appleRevokeToken;
    switch (user.authProvider) {
      case AuthProvider.google:
        (await _userRepository.reauthenticateWithGoogle()).getOrThrow();
      case AuthProvider.apple:
        appleRevokeToken = (await _userRepository.reauthenticateWithApple())
            .getOrThrow();
    }

    (await _diagnosisRepository.deleteDiagnosisProfile()).getOrThrow();
    (await _noteRepository.deleteSolvedRecordHistory()).getOrThrow();
    (await _userRepository.deleteUserData()).getOrThrow();
    if (appleRevokeToken != null) {
      (await _userRepository.revokeAppleToken(appleRevokeToken)).getOrThrow();
    }
    (await _userRepository.deleteAccount()).getOrThrow();
  }
}
