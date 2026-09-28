import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repositoriesImpl/diagnosis_repository_impl.dart';
import '../data/repositoriesImpl/note_repository_impl.dart';
import '../data/repositoriesImpl/quiz_repository_impl.dart';
import '../data/repositoriesImpl/user_repository_impl.dart';
import '../domain/repositories/diagnosis_repository.dart';
import '../domain/repositories/note_repository.dart';
import '../domain/repositories/quiz_repository.dart';
import '../domain/repositories/user_repository.dart';
import 'service_providers.dart';

part 'repository_providers.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(
    authService: ref.watch(authServiceProvider),
    firestoreService: ref.watch(firestoreServiceProvider),
  );
}

@riverpod
DiagnosisRepository diagnosisRepository(Ref ref) {
  return DiagnosisRepositoryImpl(
    firestore: ref.watch(firestoreServiceProvider),
    auth: ref.watch(authServiceProvider),
    llm: ref.watch(llmServiceProvider),
  );
}

@riverpod
QuizRepository quizRepository(Ref ref) {
  return QuizRepositoryImpl(llm: ref.watch(llmServiceProvider));
}

@riverpod
NoteRepository noteRepository(Ref ref) {
  return NoteRepositoryImpl(
    auth: ref.watch(authServiceProvider),
    firestore: ref.watch(firestoreServiceProvider),
  );
}
