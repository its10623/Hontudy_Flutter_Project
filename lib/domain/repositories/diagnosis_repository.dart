import 'package:result_dart/result_dart.dart';

import '../models/diagnosis_profile.dart';
import '../models/diagnosis_turn.dart';

abstract class DiagnosisRepository {
  AsyncResult<DiagnosisTurn> requestDiagnosisTurn(List<DiagnosisAnswer> history);
  AsyncResult<DiagnosisResult> requestDiagnosisClassification(List<DiagnosisAnswer> history);
  AsyncResult<void> saveDiagnosisProfile(DiagnosisProfile profile);
  AsyncResult<(DiagnosisProfile?,)> fetchDiagnosisProfile();
  AsyncResult<List<DiagnosisProfile>> fetchDiagnosisProfileHistory();
}
