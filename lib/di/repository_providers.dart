import 'package:hontudy/data/repositoriesImpl/report_repository_impl.dart';
import 'package:hontudy/domain/repositories/app_info_repository.dart';
import 'package:hontudy/domain/repositories/report_repository.dart';
import 'package:hontudy/domain/repositories/support_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repositoriesImpl/app_info_repository_impl.dart';
import '../data/repositoriesImpl/diagnosis_repository_impl.dart';
import '../data/repositoriesImpl/note_repository_impl.dart';
import '../data/repositoriesImpl/quiz_repository_impl.dart';
import '../data/repositoriesImpl/support_repository_impl.dart';
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
    auth: ref.watch(authServiceProvider),
    firestoreService: ref.watch(firestoreServiceProvider),
  );
}

@riverpod
DiagnosisRepository diagnosisRepository(Ref ref) {
  return DiagnosisRepositoryImpl(
    firestore: ref.watch(firestoreServiceProvider),
    auth: ref.watch(authServiceProvider),
    ai: ref.watch(aiFunctionsServiceProvider),
  );
}

@riverpod
QuizRepository quizRepository(Ref ref) {
  return QuizRepositoryImpl(
    ai: ref.watch(aiFunctionsServiceProvider),
  );
}

@riverpod
NoteRepository noteRepository(Ref ref) {
  return NoteRepositoryImpl(
    auth: ref.watch(authServiceProvider),
    firestore: ref.watch(firestoreServiceProvider),
  );
}

@riverpod
ReportRepository reportRepository(Ref ref) {
  return ReportRepositoryImpl(
    firestore: ref.watch(firestoreServiceProvider),
    auth: ref.watch(authServiceProvider),
    appInfo: ref.watch(appInfoServiceProvider),
  );
}

@riverpod
AppInfoRepository appInfoRepository(Ref ref) {
  return AppInfoRepositoryImpl(
    appInfo: ref.watch(appInfoServiceProvider),
  );
}

@riverpod
SupportRepository supportRepository(Ref ref) {
  return SupportRepositoryImpl(
    email: ref.watch(emailServiceProvider),
    appInfo: ref.watch(appInfoServiceProvider),
    deviceInfo: ref.watch(deviceInfoServiceProvider),
  );
}