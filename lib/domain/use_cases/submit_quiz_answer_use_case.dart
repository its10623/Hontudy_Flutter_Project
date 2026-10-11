import 'package:hontudy/domain/models/quiz.dart';
import 'package:hontudy/domain/models/quiz_feedback.dart';
import 'package:hontudy/domain/models/solved_record.dart';
import 'package:result_dart/result_dart.dart';

import '../repositories/note_repository.dart';
import '../repositories/quiz_repository.dart';

class SubmitQuizAnswerUseCase {
  final QuizRepository _quizRepository;
  final NoteRepository _noteRepository;

  SubmitQuizAnswerUseCase({
    required this._quizRepository,
    required this._noteRepository,
  });

  Future<QuizFeedback> call({
    required Quiz quiz,
    required String userAnswer,
  }) async {
    final feedback = await _quizRepository
        .submitAnswer(
          quiz: quiz,
          userAnswer: userAnswer,
        )
        .fold(
          (feedback) => feedback,
          (failure) => throw failure,
        );
    // 문제와 무관한 답은 풀이로 치지 않고 노트,재출제 제외에 섞이지 않게 함
    if (feedback.isOffTopic) return feedback;
    final time = DateTime.now();
    final record = SolvedRecord(
      timestamp: time,
      quiz: quiz,
      quizFeedback: feedback,
      userAnswer: userAnswer,
    );
    final saveRecord = await _noteRepository.saveSolvedRecord(record);
    saveRecord.fold(
      (success) => success,
      (failure) => throw failure,
    );
    return feedback;
  }
}
