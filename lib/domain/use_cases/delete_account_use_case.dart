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

  Future<void> call() async {
    final deleteProfile = await _diagnosisRepository.deleteDiagnosisProfile();
    deleteProfile.fold(
      (success) => success,
      (failure) => throw failure,
    );

    final deleteNote = await _noteRepository.deleteSolvedRecordHistory();
    deleteNote.fold(
      (success) => success,
      (failure) => throw failure,
    );

    final deleteAccount = await _userRepository.deleteAccount();

    deleteAccount.fold(
      (success) => success,
      (failure) => throw failure,
    );
  }
}
