import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:hontudy/domain/models/category_scheme.dart';
import 'package:hontudy/data/llm_plain_text.dart';
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
    required QuizFormat format,
    required String targetMain,
  }) {
    return guardAsync(() async {
      final prompt = PromptBuilder.buildQuizPrompt(
        profile: profile,
        excludeKeywords: excludeKeywords,
        format: format,
        targetMain: targetMain,
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
    final options = rawOptions
        .map((option) => llmPlainText(option.toString()))
        .toList();
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
        : llmPlainText(json['reference_answer'] as String? ?? '');

    final imageUrl = widgetType == 'image_diagram'
        ? await _requiredImageUrl(widgetContent?['image_prompt'])
        : null;

    return Quiz(
      qid: const Uuid().v4(),
      questionText: llmPlainText(json['question_text'] as String),
      category: Category(
        main: _mainCategoryFromJson(category['main']),
        topic: category['topic'] as String,
        subTopic: category['subtopic'] as String,
      ),
      difficulty: json['difficulty'] as String,
      referenceAnswer: referenceAnswer,
      quizContent: quizContent,
      codeSnippet:
          _codeSnippetFromJson(json['code_snippet']) ??
          (widgetType == 'code_block'
              ? _codeSnippetFromJson(widgetContent)
              : null),
      imageUrl: imageUrl,
    );
  }

  Future<QuizFeedback> _quizFeedbackFromJson(Map<String, dynamic> json) async {
    final imagePrompt = json['image_prompt'] as String?;
    final imageUrl = imagePrompt == null
        ? null
        : await _optionalImageUrl(imagePrompt);

    final isOffTopic = json['is_off_topic'] == true;
    return QuizFeedback(
      isCorrect: !isOffTopic && json['is_correct'] as bool,
      isOffTopic: isOffTopic,
      feedbackText: llmPlainText(json['feedback_text'] as String),
      keyPoint: llmPlainTextOrNull(json['key_point'] as String?),
      imageUrl: imageUrl,
      codeSnippet: _codeSnippetFromJson(json['code_block']),
    );
  }

  /// 이미지를 만들지 못하면 문제 재출제
  Future<String> _requiredImageUrl(Object? imagePrompt) async {
    if (imagePrompt is! String || imagePrompt.trim().isEmpty) {
      throw QuizImageUnavailableException();
    }
    try {
      final prompt = PromptBuilder.buildQuizImagePrompt(
        imagePrompt: imagePrompt,
      );
      return await _ai.generateImage(prompt: prompt);
    } on FirebaseException catch (e) {
      if (e.code == 'resource-exhausted') rethrow;
      throw QuizImageUnavailableException();
    } on Exception {
      throw QuizImageUnavailableException();
    }
  }

  /// 해설 이미지는 보조 자료라 실패해도 해설만 보여 준다.
  Future<String?> _optionalImageUrl(String imagePrompt) async {
    try {
      final prompt = PromptBuilder.buildExplanationImagePrompt(
        imagePrompt: imagePrompt,
      );
      return await _ai.generateImage(prompt: prompt);
    } on Exception {
      return null;
    }
  }

  /// 기준 목록 밖의 주제는 노트에서 중복,미분류로 보이므로 거부
  String _mainCategoryFromJson(Object? raw) {
    final main = raw is String ? CategoryScheme.normalizeMain(raw) : null;
    if (main == null) throw FormatException('알 수 없는 메인 주제: $raw');
    return main;
  }

  CodeSnippet? _codeSnippetFromJson(Object? raw) {
    if (raw is! Map<String, dynamic>) return null;
    final code = raw['code'];
    if (code is! String || code.trim().isEmpty) return null;
    final language = raw['language'];
    return CodeSnippet(
      language: language is String ? language : 'text',
      code: code,
    );
  }
}
