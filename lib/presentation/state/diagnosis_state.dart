import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/models/diagnosis_turn.dart';

part 'diagnosis_state.freezed.dart';

@freezed
class DiagnosisState with _$DiagnosisState {
  final List<DiagnosisMessage> messages;
  final DiagnosisPhase phase;

  const DiagnosisState({
    required this.messages,
    required this.phase,
  });

  List<DiagnosisAnswer> get history {
    final answers = <DiagnosisAnswer>[];
    String? pendingQuestion;

    for (final message in messages) {
      switch (message) {
        case AiQuestion(:final questionText):
          pendingQuestion = questionText;
        case UserAnswer(:final text, :final offTopic):
          if (offTopic || pendingQuestion == null) continue;
          answers.add(
            DiagnosisAnswer(questionText: pendingQuestion, answerText: text),
          );
          pendingQuestion = null;
        case AiSummary():
        case AiNotice():
          break;
      }
    }
    return answers;
  }

  Map<String, String> get answersByQuestionId {
    final answers = <String, String>{};
    String? pendingQuestionId;

    for (final message in messages) {
      switch (message) {
        case AiQuestion(:final id):
          pendingQuestionId = id;
        case UserAnswer(:final text, :final offTopic):
          if (offTopic || pendingQuestionId == null) continue;
          answers[pendingQuestionId] = text;
          pendingQuestionId = null;
        case AiSummary():
        case AiNotice():
          break;
      }
    }
    return answers;
  }

  int get turnCount => history.length;

  AiQuestion? get activeQuestion {
    if (phase is! WaitingAnswer) return null;
    for (final message in messages.reversed) {
      switch (message) {
        case AiNotice():
        case UserAnswer(offTopic: true):
          continue;
        case final AiQuestion question:
          return question;
        default:
          return null;
      }
    }
    return null;
  }

  int get offTopicStreak {
    var count = 0;
    for (final message in messages.reversed) {
      switch (message) {
        case AiNotice():
          continue;
        case UserAnswer(offTopic: true):
          count++;
        default:
          return count;
      }
    }
    return count;
  }

  DiagnosisResult? get summaryResult =>
      messages.whereType<AiSummary>().lastOrNull?.result;
}

@freezed
sealed class DiagnosisMessage with _$DiagnosisMessage {
  const DiagnosisMessage._();

  const factory DiagnosisMessage.aiQuestion({
    required String id,
    required DateTime createdAt,
    required String questionText,
    required DiagnosisContent content,
  }) = AiQuestion;

  const factory DiagnosisMessage.userAnswer({
    required String id,
    required DateTime createdAt,
    required String text,
    @Default(false) bool offTopic,
  }) = UserAnswer;

  const factory DiagnosisMessage.aiNotice({
    required String id,
    required DateTime createdAt,
    required String text,
  }) = AiNotice;

  const factory DiagnosisMessage.aiSummary({
    required String id,
    required DateTime createdAt,
    required DiagnosisResult result,
  }) = AiSummary;
}

@freezed
sealed class DiagnosisPhase with _$DiagnosisPhase {
  const DiagnosisPhase._();

  const factory DiagnosisPhase.waitingAnswer() = WaitingAnswer;
  const factory DiagnosisPhase.sending() = Sending;
  const factory DiagnosisPhase.classifying() = Classifying;
  const factory DiagnosisPhase.confirming() = Confirming;
  const factory DiagnosisPhase.failed({
    required Object error,
    required DiagnosisRetryTarget retryTarget,
  }) = Failed;
  const factory DiagnosisPhase.completed({required DiagnosisProfile profile}) =
      Completed;
}

enum DiagnosisRetryTarget { turn, classification }
