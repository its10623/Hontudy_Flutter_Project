import 'package:hontudy/data/dto/diagnosis_profile_dto.dart';
import 'package:hontudy/data/prompt_builder.dart';
import 'package:hontudy/data/result_guard.dart';
import 'package:hontudy/data/services/remotes/auth_service.dart';
import 'package:hontudy/data/services/remotes/ai_functions_service.dart';
import 'package:hontudy/domain/models/category_scheme.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/models/diagnosis_scheme.dart';
import 'package:hontudy/domain/models/diagnosis_turn.dart';
import 'package:hontudy/domain/repositories/diagnosis_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../services/remotes/firestore_service.dart';

class DiagnosisRepositoryImpl implements DiagnosisRepository {
  final FirestoreService _firestore;
  final AuthService _auth;
  final AiFunctionsService _ai;

  DiagnosisRepositoryImpl({
    required this._firestore,
    required this._auth,
    required this._ai,
  });

  String _requiredUid() => _auth.currentUser!.uid;

  @override
  AsyncResult<void> saveDiagnosisProfile(DiagnosisProfile profile) async {
    return guardAsync(() async {
      await _firestore.saveDiagnosisProfile(_requiredUid(), profile);
      return unit;
    });
  }

  @override
  AsyncResult<DiagnosisResult> requestDiagnosisClassification(
    List<DiagnosisAnswer> history,
  ) {
    return guardAsync(() async {
      final prompt = PromptBuilder.buildDiagnosisClassificationPrompt(history);
      final json = await _ai.sendPrompt(
        messages: [
          {'role': 'user', 'content': prompt},
        ],
        temperature: 0.2,
      );
      return _diagnosisResultFromJson(json);
    });
  }

  @override
  AsyncResult<DiagnosisTurn> requestDiagnosisTurn(
    List<DiagnosisAnswer> history,
  ) {
    return guardAsync(() async {
      final recentAnswer = history.last;
      final pastHistory = history.sublist(0, history.length - 1);
      final prompt = PromptBuilder.buildDiagnosisPrompt(
        turnCount: history.length,
        history: pastHistory,
        userInput: recentAnswer,
      );
      final json = await _ai.sendPrompt(
        messages: [
          {'role': 'user', 'content': prompt},
        ],
        temperature: 0.2,
      );
      return _diagnosisTurnFromJson(json);
    });
  }

  @override
  AsyncResult<(DiagnosisProfile?,)> fetchDiagnosisProfile() {
    return guardAsync(() async {
      final dto = await _firestore.fetchDiagnosisProfile(_requiredUid());
      final profile = dto == null ? null : DiagnosisProfileMapper.toDomain(dto);
      return (profile,);
    });
  }

  @override
  AsyncResult<List<DiagnosisProfile>> fetchDiagnosisProfileHistory() {
    return guardAsync(() async {
      final dtos = await _firestore.fetchDiagnosisProfileHistory(
        _requiredUid(),
      );
      final profile = dtos.map(DiagnosisProfileMapper.toDomain).toList();
      return profile;
    });
  }

  List<String> _whitelistedStrings(
    Object? raw, {
    required Iterable<String> allowed,
    int? limit,
  }) {
    if (raw is! List) return const [];
    final allowedSet = allowed.toSet();
    final values = raw
        .map((value) => value.toString())
        .where(allowedSet.contains)
        .toSet()
        .toList();
    return limit == null ? values : values.take(limit).toList();
  }

  DiagnosisResult _diagnosisResultFromJson(Map<String, dynamic> json) {
    return DiagnosisResult(
      profile: DiagnosisProfile(
        background: json['background'] as String,
        difficultyScore: json['difficulty_score'] as int,
        purposeTags: _whitelistedStrings(
          json['purpose_tags'],
          allowed: DiagnosisScheme.purposeTags.map((purpose) => purpose.tag),
        ),
        weakAreas: _whitelistedStrings(
          json['weak_areas'],
          allowed: CategoryScheme.mainCategories.map((main) => main.name),
          limit: 3,
        ),
        timestamp: DateTime.now(),
      ),
      backgroundDetail: json['background_detail'] as String?,
      reasoning: json['reasoning'] as String,
      confidence: json['confidence'] as int,
    );
  }

  DiagnosisTurn _diagnosisTurnFromJson(Map<String, dynamic> json) {
    return DiagnosisTurn(
      confidence: json['confidence'] as int,
      nextAction: json['next_action'] as String,
      questionText: json['question_text'] as String,
      diagnosisContent: switch (json['widget_type']) {
        'free_text_input' => const DiagnosisContent.freeTextInput(),
        'choice_chips' => DiagnosisContent.choiceChips(
          options: List<String>.from(json['widget_content']['options'] as List),
        ),
        'single_choice_list' => DiagnosisContent.singleChoiceList(
          options: List<String>.from(json['widget_content']['options'] as List),
        ),
        'summary_confirm' => DiagnosisContent.summaryConfirm(
          summaryText: json['widget_content']['summary_text'] as String,
          reasoningText: json['reasoning'] as String,
        ),
        _ => throw Exception('알 수 없는 widget_type: ${json['widget_type']}'),
      },
    );
  }

  @override
  AsyncResult<void> deleteDiagnosisProfile() {
    return guardAsync(() async {
      await _firestore.deleteDiagnosisProfileHistory(_requiredUid());
      return unit;
    });
  }
}
