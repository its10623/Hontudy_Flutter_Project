import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hontudy/data/dto/diagnosis_profile_dto.dart';
import 'package:hontudy/data/dto/solved_record_dto.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/models/solved_record.dart';

import '../../../domain/repositories/note_repository.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  CollectionReference<Map<String, dynamic>> get _userRef =>
      _firestore.collection('users');

  CollectionReference<Map<String, dynamic>> _diagnosisProfileRef(String uid) =>
      _userRef.doc(uid).collection('diagnosisProfile');

  CollectionReference<Map<String, dynamic>> _solvedRecordRef(String uid) =>
      _userRef.doc(uid).collection('solvedRecord');

  Future<void> saveDiagnosisProfile(String uid, DiagnosisProfile profile) {
    return _diagnosisProfileRef(
      uid,
    ).add(DiagnosisProfileMapper.toDto(profile).toJson());
  }

  Future<void> saveSolvedRecord(String uid, SolvedRecord record) {
    return _solvedRecordRef(uid).add(SolvedRecordMapper.toDto(record).toJson());
  }

  Future<void> saveTermsAgreement(String uid) {
    return _userRef.doc(uid).set({
      'hasAgreedToTerms': true,
    }, SetOptions(merge: true));
  }

  Future<DiagnosisProfileDto?> fetchDiagnosisProfile(String uid) async {
    final snapshot = await _diagnosisProfileRef(
      uid,
    ).orderBy('timestamp', descending: true).limit(1).get();

    if (snapshot.docs.isEmpty) return null;
    return DiagnosisProfileDto.fromJson(snapshot.docs.first.data());
  }

  Future<List<DiagnosisProfileDto>> fetchDiagnosisProfileHistory(
    String uid,
  ) async {
    final snapshot = await _diagnosisProfileRef(
      uid,
    ).orderBy('timestamp', descending: true).get();
    final profiles = snapshot.docs
        .map((doc) => DiagnosisProfileDto.fromJson(doc.data()))
        .toList();
    return profiles;
  }

  Future<List<SolvedRecordDto>> fetchRecentSolvedRecords(
    String uid,
    int days,
  ) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final snapshot = await _solvedRecordRef(uid)
        .where('timestamp', isGreaterThanOrEqualTo: cutoff)
        .orderBy('timestamp', descending: true)
        .get();
    final records = snapshot.docs
        .map((doc) => SolvedRecordDto.fromJson(doc.data()))
        .toList();
    return records;
  }

  Future<List<SolvedRecordDto>> fetchSolvedRecords(
    String uid, {
    required NoteFilter filter,
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _solvedRecordRef(
      uid,
    ).orderBy('timestamp', descending: true);
    if (filter == NoteFilter.correctOnly) {
      query = query.where('quizFeedback.isCorrect', isEqualTo: true);
    } else if (filter == NoteFilter.wrongOnly) {
      query = query.where('quizFeedback.isCorrect', isEqualTo: false);
    }

    if (limit != null) {
      query = query.limit(limit);
    }
    final snapshot = await query.get();
    final records = snapshot.docs
        .map((doc) => SolvedRecordDto.fromJson(doc.data()))
        .toList();
    return records;
  }

  Future<bool> fetchTermsAgreement(String uid) async {
    final doc = await _userRef.doc(uid).get();
    return doc.data()?['hasAgreedToTerms'] as bool? ?? false;
  }

  Future<void> deleteDiagnosisProfileHistory(String uid) =>
      _deleteAll(_diagnosisProfileRef(uid));

  Future<void> deleteSolvedRecordHistory(String uid) =>
      _deleteAll(_solvedRecordRef(uid));

  Future<void> deleteUserDocument(String uid) => _userRef.doc(uid).delete();

  Future<void> _deleteAll(CollectionReference<Map<String, dynamic>> ref) async {
    const batchLimit = 500;
    final snapshot = await ref.get();
    final docs = snapshot.docs;
    for (var start = 0; start < docs.length; start += batchLimit) {
      final batch = _firestore.batch();
      for (final doc in docs.skip(start).take(batchLimit)) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }
}
