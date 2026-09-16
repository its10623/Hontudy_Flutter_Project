import 'package:freezed_annotation/freezed_annotation.dart';

import 'category.dart';

part 'quiz.freezed.dart';

@freezed
class Quiz with _$Quiz {
  final String questionText;
  final Category category;
  final String difficulty;
  final String widgetType;
  final Map<String, dynamic>? widgetContent;
  final String referenceAnswer;

  const Quiz({
    required this.questionText,
    required this.category,
    required this.difficulty,
    required this.widgetType,
    this.widgetContent,
    required this.referenceAnswer,
  });
}
