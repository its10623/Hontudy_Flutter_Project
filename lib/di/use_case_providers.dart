import 'package:hontudy/domain/use_cases/submit_quiz_answer_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/use_cases/request_quiz_use_case.dart';
import 'repository_providers.dart';

part 'use_case_providers.g.dart';

@riverpod
RequestQuizUseCase requestQuizUseCase(Ref ref) {
  return RequestQuizUseCase(
    quizRepository: ref.watch(quizRepositoryProvider),
    noteRepository: ref.watch(noteRepositoryProvider),
    diagnosisRepository: ref.watch(diagnosisRepositoryProvider),
  );
}

@riverpod
SubmitQuizAnswerUseCase submitQuizAnswerUseCase(Ref ref) {
  return SubmitQuizAnswerUseCase(
    quizRepository: ref.watch(quizRepositoryProvider),
    noteRepository: ref.watch(noteRepositoryProvider),
  );
}