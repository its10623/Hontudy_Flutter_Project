import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/services/remotes/auth_service.dart';
import '../data/services/remotes/firestore_service.dart';
import '../data/services/remotes/ai_functions_service.dart';

part 'service_providers.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService(FirebaseAuth.instance, GoogleSignIn.instance);
}

@riverpod
FirestoreService firestoreService(Ref ref) {
  return FirestoreService(FirebaseFirestore.instance);
}

/// Cloud Functions 리전은 서버(functions/src/index.ts)의 REGION과 같아야 한다.
const functionsRegion = 'us-central1';

@riverpod
AiFunctionsService aiFunctionsService(Ref ref) {
  return AiFunctionsService(
    FirebaseFunctions.instanceFor(region: functionsRegion),
  );
}
