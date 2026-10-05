import 'package:hontudy/data/prompt_builder.dart';
import 'package:hontudy/data/result_guard.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/models/quiz.dart';
import 'package:hontudy/domain/models/quiz_feedback.dart';
import 'package:hontudy/domain/repositories/quiz_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../../domain/exceptions.dart';
import '../services/remotes/ai_functions_service.dart';

class QuizRepositoryImpl implements QuizRepository {
  final AiFunctionsService _ai;

  QuizRepositoryImpl({required this._ai});

  @override
  AsyncResult<Quiz> requestQuiz({
    required DiagnosisProfile profile,
    required List<String> excludeKeywords,
  }) {
    return guardAsync(() async {
      final prompt = PromptBuilder.buildQuizPrompt(
        profile: profile,
        excludeKeywords: excludeKeywords,
      );
      final json = await _ai.sendPrompt(
        messages: [
          {'role': 'user', 'content': prompt},
        ],
        temperature: 0.2,
      );

      if (json['is_exhausted'] == true) {
        throw QuizDomainExhaustedException();
      }

      return await _quizFromJson(json);
    });
  }

  @override
  AsyncResult<QuizFeedback> submitAnswer({
    required Quiz quiz,
    required String userAnswer,
  }) {
    return guardAsync(() async {
      final prompt = PromptBuilder.buildFeedbackPrompt(
        quiz: quiz,
        userAnswer: userAnswer,
      );
      final json = await _ai.sendPrompt(
        messages: [
          {'role': 'user', 'content': prompt},
        ],
        temperature: 0.2,
      );
      return await _quizFeedbackFromJson(json);
    });
  }


  /// 보기 수나 정답 번호가 맞지 않으면 화면에 그리지 않도록 거부.
  QuizContent _singleChoiceFromJson(
    Map<String, dynamic> json,
    Map<String, dynamic>? widgetContent,
  ) {
    final rawOptions =
        (json['choices'] ?? widgetContent?['options']) as List<dynamic>?;
    final rawIndex =
        (json['correct_index'] ?? widgetContent?['correctIndex']) as num?;

    if (rawOptions == null || rawOptions.length < 2 || rawOptions.length > 5) {
      throw FormatException('객관식 보기 수가 올바르지 않음: $rawOptions');
    }
    final options = rawOptions.map((option) => option.toString()).toList();
    final correctIndex = rawIndex?.toInt();
    if (correctIndex == null ||
        correctIndex < 0 ||
        correctIndex >= options.length) {
      throw FormatException('객관식 정답 번호가 올바르지 않음: $rawIndex');
    }
    return QuizContent.singleChoice(
      options: options,
      correctIndex: correctIndex,
    );
  }

  Future<Quiz> _quizFromJson(Map<String, dynamic> json) async {
    final category = json['category'] as Map<String, dynamic>;
    final widgetType = json['widget_type'] as String;
    final widgetContent = json['widget_content'] as Map<String, dynamic>?;

    final quizContent = switch (widgetType) {
      'single_choice_question' => _singleChoiceFromJson(json, widgetContent),
      'short_answer_input' ||
      'code_block' ||
      'image_diagram' ||
      'math_formula' => const QuizContent.shortAnswer(),
      _ => throw Exception('알 수 없는 widget_type: $widgetType'),
    };

    final referenceAnswer = quizContent is SingleChoiceContent
        ? quizContent.options[quizContent.correctIndex]
        : json['reference_answer'] as String? ?? '';

    String? imageUrl;
    if (widgetType == 'image_diagram' && widgetContent != null) {
      final imagePrompt = widgetContent['image_prompt'] as String?;
      if (imagePrompt != null) {
        imageUrl = await _ai.generateImage(
          prompt: imagePrompt,
        );
      }
    }

    return Quiz(
      qid: const Uuid().v4(),
      questionText: json['question_text'] as String,
      category: Category(
        main: category['main'] as String,
        topic: category['topic'] as String,
        subTopic: category['subtopic'] as String,
      ),
      difficulty: json['difficulty'] as String,
      referenceAnswer: referenceAnswer,
      quizContent: quizContent,
      codeSnippet: widgetType == 'code_block' && widgetContent != null
          ? CodeSnippet(
              language: widgetContent['language'] as String,
              code: widgetContent['code'] as String,
            )
          : null,
      imageUrl: imageUrl,
    );
  }

  Future<QuizFeedback> _quizFeedbackFromJson(Map<String, dynamic> json) async {
    final codeBlock = json['code_block'] as Map<String, dynamic>?;
    final imagePrompt = json['image_prompt'] as String?;
    final imageUrl = imagePrompt == null
        ? null
        : await _ai.generateImage(
            prompt: imagePrompt,
          );

    return QuizFeedback(
      isCorrect: json['is_correct'] as bool,
      feedbackText: json['feedback_text'] as String,
      keyPoint: json['key_point'] as String?,
      imageUrl: imageUrl,
      codeSnippet: codeBlock == null
          ? null
          : CodeSnippet(
              language: codeBlock['language'] as String,
              code: codeBlock['code'] as String,
            ),
    );
  }
}
