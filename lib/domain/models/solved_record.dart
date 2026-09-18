import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/domain/models/quiz.dart';

import '../../presentation/views/component/genui/answer_feeback.dart';

part 'solved_record.freezed.dart';

@freezed
class SolvedRecord with _$SolvedRecord {
  final Quiz quiz;
  final String userAnswer;
  final AnswerFeedback answerFeedback;
  final DateTime timestamp;

  const SolvedRecord({
    required this.quiz,
    required this.userAnswer,
    required this.answerFeedback,
    required this.timestamp,
  });
}
