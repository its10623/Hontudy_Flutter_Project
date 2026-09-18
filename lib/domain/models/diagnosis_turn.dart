import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_turn.freezed.dart';

@freezed
class DiagnosisTurn with _$DiagnosisTurn {
  final int confidence;
  final String nextAction;
  final String questionText;
  final DiagnosisContent diagnosisContent;

  const DiagnosisTurn({
    required this.confidence,
    required this.nextAction,
    required this.questionText, required this.diagnosisContent,
  });

}

@freezed
sealed class DiagnosisContent with _$DiagnosisContent {
  const DiagnosisContent._();

  const factory DiagnosisContent.freeTextInput() = FreeTextInputContent;

  const factory DiagnosisContent.choiceChips({
    required List<String> options,
  }) = ChoiceChipsContent;

  const factory DiagnosisContent.singleChoiceList({
    required List<String> options,
  }) = SingleChoiceListContent;

  const factory DiagnosisContent.summaryConfirm({
    required String summaryText,
    required String reasoningText,
  }) = SummaryConfirmContent;

  String get widgetType => switch (this) {
    FreeTextInputContent() => 'free_text_input',
    ChoiceChipsContent() => 'choice_chips',
    SingleChoiceListContent() => 'single_choice_list',
    SummaryConfirmContent() => 'summary_confirm',
  };
}

@freezed
class DiagnosisAnswer with _$DiagnosisAnswer {
  final String questionText;
  final String answerText;

  const DiagnosisAnswer({
    required this.questionText,
    required this.answerText,
  });
}
