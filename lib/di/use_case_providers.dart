import 'package:hontudy/domain/use_cases/delete_account_use_case.dart';
import 'package:hontudy/domain/use_cases/determine_next_route_use_case.dart';
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

@riverpod
DeleteAccountUseCase deleteAccountUseCase(Ref ref) {
  return DeleteAccountUseCase(
    userRepository: ref.watch(userRepositoryProvider),
    diagnosisRepository: ref.watch(diagnosisRepositoryProvider),
    noteRepository: ref.watch(noteRepositoryProvider),
  );
}

@riverpod
DetermineNextRouteUseCase determineNextRouteUseCase(Ref ref) {
  return DetermineNextRouteUseCase(
    userRepository: ref.watch(userRepositoryProvider),
    diagnosisRepository: ref.watch(diagnosisRepositoryProvider),
  );
}
