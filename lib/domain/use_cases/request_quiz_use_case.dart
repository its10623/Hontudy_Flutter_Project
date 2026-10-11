import 'dart:math';

import 'package:hontudy/domain/exceptions.dart';
import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/repositories/diagnosis_repository.dart';
import 'package:hontudy/domain/repositories/note_repository.dart';
import 'package:hontudy/domain/repositories/quiz_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../models/quiz.dart';

sealed class RequestQuizResult {}

class QuizReady extends RequestQuizResult {
  final Quiz quiz;

  QuizReady(this.quiz);
}

class ReviewModeRequired extends RequestQuizResult {}

class RequestQuizUseCase {
  final QuizRepository _quizRepository;
  final NoteRepository _noteRepository;
  final DiagnosisRepository _diagnosisRepository;

  static const _maxRetries = 5;
  static const _singleChoiceRatio = 0.6;
  final Random _random;

  RequestQuizUseCase({
    required this._quizRepository,
    required this._noteRepository,
    required this._diagnosisRepository,
    Random? random,
  }) : _random = random ?? Random();

  Future<RequestQuizResult> call({DiagnosisProfile? diagnosisProfile}) async {
    final excludeKeywords = await _noteRepository
        .fetchRecentSolvedRecords(7)
        .fold(
          (records) => records
              .map((record) => record.quiz.category.subTopic)
              .toSet()
              .take(10)
              .toList(),
          (failure) => throw failure,
        );
    final profile =
        diagnosisProfile ??
        await _diagnosisRepository.fetchDiagnosisProfile().fold(
          (record) => record.$1,
          (failure) => throw failure,
        );
    if (profile == null) throw DiagnosisProfileEmptyException();

    final format = _random.nextDouble() < _singleChoiceRatio
        ? QuizFormat.singleChoice
        : QuizFormat.shortAnswer;
    final keywords = List<String>.from(excludeKeywords);
    for (var attempt = 0; attempt < _maxRetries; attempt++) {
      try {
        final quiz = await _quizRepository
            .requestQuiz(
              profile: profile,
              excludeKeywords: keywords,
              format: format,
            )
            .fold(
              (success) => success,
              (failure) => throw failure,
            );
        return QuizReady(quiz);
      } on QuizDomainExhaustedException {
        if (keywords.isEmpty) break;
        keywords.removeLast();
      }
    }
    return ReviewModeRequired();
  }
}
