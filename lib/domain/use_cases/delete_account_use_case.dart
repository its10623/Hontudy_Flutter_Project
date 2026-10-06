import 'package:hontudy/domain/models/user.dart';
import 'package:hontudy/domain/repositories/diagnosis_repository.dart';
import 'package:hontudy/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';

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
        await _getOrThrow(_userRepository.reauthenticateWithGoogle());
      case AuthProvider.apple:
        appleRevokeToken = await _valueOrThrow(
          _userRepository.reauthenticateWithApple(),
        );
    }

    await _getOrThrow(_diagnosisRepository.deleteDiagnosisProfile());
    await _getOrThrow(_noteRepository.deleteSolvedRecordHistory());
    await _getOrThrow(_userRepository.deleteUserData());
    if (appleRevokeToken != null) {
      await _getOrThrow(_userRepository.revokeAppleToken(appleRevokeToken));
    }
    await _getOrThrow(_userRepository.deleteAccount());
  }

  Future<T> _valueOrThrow<T extends Object>(AsyncResult<T> result) async {
    return (await result).fold(
      (success) => success,
      (failure) => throw failure,
    );
  }

  Future<void> _getOrThrow(AsyncResult<void> result) async {
    (await result).fold(
      (success) => success,
      (failure) => throw failure,
    );
  }
}
