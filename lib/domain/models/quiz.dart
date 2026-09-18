import 'package:freezed_annotation/freezed_annotation.dart';

import 'category.dart';

part 'quiz.freezed.dart';

@freezed
class Quiz with _$Quiz {
  final String qid;
  final String questionText;
  final Category category;
  final String difficulty;
  final String referenceAnswer;
  final String? imageUrl;
  final CodeSnippet? codeSnippet;
  final QuizContent quizContent;

  const Quiz({
    required this.questionText,
    required this.category,
    required this.difficulty,
    required this.referenceAnswer,
    required this.quizContent,
    this.imageUrl,
    this.codeSnippet,
    required this.qid,
  });
}

@freezed
class CodeSnippet with _$CodeSnippet {
  final String language;
  final String code;

  CodeSnippet({
    required this.language,
    required this.code,
  });
}

@freezed
sealed class QuizContent with _$QuizContent {
  const QuizContent._();

  const factory QuizContent.shortAnswer() = ShortAnswerContent;

  const factory QuizContent.singleChoice({
    required List<String> options,
    required int correctIndex,
  }) = SingleChoiceContent;

  String get widgetType => switch (this) {
    SingleChoiceContent() => 'single_choice_question',
    ShortAnswerContent() => 'short_answer_input',
  };
}
