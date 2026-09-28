import 'package:hontudy/data/dto/solved_record_dto.dart';
import 'package:hontudy/data/result_guard.dart';
import 'package:hontudy/domain/models/solved_record.dart';
import 'package:hontudy/domain/repositories/note_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../services/remotes/auth_service.dart';
import '../services/remotes/firestore_service.dart';

class NoteRepositoryImpl implements NoteRepository {
  final AuthService _auth;
  final FirestoreService _firestore;

  NoteRepositoryImpl({required this._auth, required this._firestore});

  String _requireUid() => _auth.currentUser!.uid;

  @override
  AsyncResult<List<SolvedRecord>> fetchRecentSolvedRecords(int days) {
    return guardAsync(() async {
      final dtos = await _firestore.fetchRecentSolvedRecords(_requireUid(), days);
      final records = dtos.map(SolvedRecordMapper.toDomain).toList();
      return records;
    });
  }

  @override
  AsyncResult<List<SolvedRecord>> fetchSolvedRecords(
      {required NoteFilter filter, int? limit}) {
    return guardAsync(() async {
      final dtos = await _firestore.fetchSolvedRecords(_requireUid(), filter: filter, limit: limit);
      final records = dtos.map(SolvedRecordMapper.toDomain).toList();
      return records;
    });
  }

  @override
  AsyncResult<void> saveSolvedRecord(SolvedRecord record) {
    return guardAsync(() async {
      await _firestore.saveSolvedRecord(_requireUid(), record);
      return unit;
    });
  }

  @override
  AsyncResult<void> deleteSolvedRecordHistory() {
    return guardAsync(() async {
      await _firestore.deleteSolvedRecordHistory(_requireUid());
      return unit;
    });
  }

}