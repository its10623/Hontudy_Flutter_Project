import 'package:result_dart/result_dart.dart';

import '../models/diagnosis_profile.dart';
import '../models/quiz.dart';
import '../models/quiz_feedback.dart';

abstract class QuizRepository {
  AsyncResult<Quiz> requestQuiz({
    required DiagnosisProfile profile,
    required List<String> excludeKeywords,
  });

  AsyncResult<QuizFeedback> submitAnswer({
    required Quiz quiz,
    required String userAnswer,
  });
}
