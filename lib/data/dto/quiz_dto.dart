import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/quiz.dart';

part 'quiz_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizDto {
  final String qid;
  final String questionText;
  final CategoryDto category;
  final String difficulty;
  final String referenceAnswer;
  final String? imageUrl;
  final CodeSnippetDto? codeSnippet;
  final QuizContentDto quizContent;

  const QuizDto({
    required this.questionText,
    required this.category,
    required this.difficulty,
    required this.referenceAnswer,
    required this.quizContent,
    this.imageUrl,
    this.codeSnippet,
    required this.qid,
  });

  factory QuizDto.fromJson(Map<String, dynamic> json) =>
      _$QuizDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuizDtoToJson(this);
}

@JsonSerializable()
class CodeSnippetDto {
  final String language;
  final String code;

  CodeSnippetDto({
    required this.language,
    required this.code,
  });

  factory CodeSnippetDto.fromJson(Map<String, dynamic> json) =>
      _$CodeSnippetDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CodeSnippetDtoToJson(this);
}

@JsonSerializable()
class CategoryDto {
  final String main;
  final String topic;
  final String subTopic;

  const CategoryDto({
    required this.main,
    required this.topic,
    required this.subTopic,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}

@JsonSerializable()
class QuizContentDto {
  final String widgetType;
  final Map<String, dynamic> content;

  QuizContentDto({
    required this.widgetType,
    required this.content,
  });

  factory QuizContentDto.fromJson(Map<String, dynamic> json) =>
      _$QuizContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuizContentDtoToJson(this);
}

class QuizMapper {
  static Quiz toDomain(QuizDto dto) {
    return Quiz(
      qid: dto.qid,
      questionText: dto.questionText,
      category: CategoryMapper.toDomain(dto.category),
      difficulty: dto.difficulty,
      referenceAnswer: dto.referenceAnswer,
      quizContent: QuizContentMapper.toDomain(dto.quizContent),
      imageUrl: dto.imageUrl,
      codeSnippet: dto.codeSnippet == null
          ? null
          : CodeSnippetMapper.toDomain(dto.codeSnippet!),
    );
  }

  static QuizDto toDto(Quiz model) {
    return QuizDto(
      qid: model.qid,
      questionText: model.questionText,
      category: CategoryMapper.toDto(model.category),
      difficulty: model.difficulty,
      referenceAnswer: model.referenceAnswer,
      quizContent: QuizContentMapper.toDto(model.quizContent),
      imageUrl: model.imageUrl,
      codeSnippet: model.codeSnippet == null
          ? null
          : CodeSnippetMapper.toDto(model.codeSnippet!),
    );
  }
}

class CategoryMapper {
  static Category toDomain(CategoryDto dto) {
    return Category(
      main: dto.main,
      topic: dto.topic,
      subTopic: dto.subTopic,
    );
  }

  static CategoryDto toDto(Category model) {
    return CategoryDto(
      main: model.main,
      topic: model.topic,
      subTopic: model.subTopic,
    );
  }
}

class CodeSnippetMapper {
  static CodeSnippet toDomain(CodeSnippetDto dto) {
    return CodeSnippet(
      language: dto.language,
      code: dto.code,
    );
  }

  static CodeSnippetDto toDto(CodeSnippet model) {
    return CodeSnippetDto(
      language: model.language,
      code: model.code,
    );
  }
}

class QuizContentMapper {
  static QuizContent toDomain(QuizContentDto dto) {
    return switch (dto.widgetType) {
      'short_answer_input' => const QuizContent.shortAnswer(),
      'single_choice_question' => QuizContent.singleChoice(
        options: List<String>.from(dto.content['options'] as List),
        correctIndex: dto.content['correctIndex'] as int,
      ),
      _ => throw Exception('알 수 없는 widgetType: ${dto.widgetType}'),
    };
  }

  static QuizContentDto toDto(QuizContent model) {
    return switch (model) {
      ShortAnswerContent() => QuizContentDto(
        widgetType: 'short_answer_input',
        content: {},
      ),
      SingleChoiceContent(:final options, :final correctIndex) =>
        QuizContentDto(
          widgetType: 'single_choice_question',
          content: {'options': options, 'correctIndex': correctIndex},
        ),
    };
  }
}
