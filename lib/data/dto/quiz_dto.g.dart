// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizDto _$QuizDtoFromJson(Map<String, dynamic> json) => QuizDto(
  questionText: json['questionText'] as String,
  category: CategoryDto.fromJson(json['category'] as Map<String, dynamic>),
  difficulty: json['difficulty'] as String,
  referenceAnswer: json['referenceAnswer'] as String,
  quizContent: QuizContentDto.fromJson(
    json['quizContent'] as Map<String, dynamic>,
  ),
  imageUrl: json['imageUrl'] as String?,
  codeSnippet: json['codeSnippet'] == null
      ? null
      : CodeSnippetDto.fromJson(json['codeSnippet'] as Map<String, dynamic>),
  qid: json['qid'] as String,
);

Map<String, dynamic> _$QuizDtoToJson(QuizDto instance) => <String, dynamic>{
  'qid': instance.qid,
  'questionText': instance.questionText,
  'category': instance.category.toJson(),
  'difficulty': instance.difficulty,
  'referenceAnswer': instance.referenceAnswer,
  'imageUrl': instance.imageUrl,
  'codeSnippet': instance.codeSnippet?.toJson(),
  'quizContent': instance.quizContent.toJson(),
};

CodeSnippetDto _$CodeSnippetDtoFromJson(Map<String, dynamic> json) =>
    CodeSnippetDto(
      language: json['language'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$CodeSnippetDtoToJson(CodeSnippetDto instance) =>
    <String, dynamic>{'language': instance.language, 'code': instance.code};

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => CategoryDto(
  main: json['main'] as String,
  topic: json['topic'] as String,
  subTopic: json['subTopic'] as String,
);

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{
      'main': instance.main,
      'topic': instance.topic,
      'subTopic': instance.subTopic,
    };

QuizContentDto _$QuizContentDtoFromJson(Map<String, dynamic> json) =>
    QuizContentDto(
      widgetType: json['widgetType'] as String,
      content: json['content'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$QuizContentDtoToJson(QuizContentDto instance) =>
    <String, dynamic>{
      'widgetType': instance.widgetType,
      'content': instance.content,
    };
