import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/network/dio/dio_client.dart';
import '../data/services/remotes/auth_service.dart';
import '../data/services/remotes/firestore_service.dart';
import '../data/services/remotes/llm_service.dart';

part 'service_providers.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService(FirebaseAuth.instance, GoogleSignIn.instance);
}

@riverpod
FirestoreService firestoreService(Ref ref) {
  return FirestoreService(FirebaseFirestore.instance);
}

@riverpod
LlmService llmService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return LlmService(dio);
}
