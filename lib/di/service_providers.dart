import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hontudy/data/services/local/device_info_service.dart';
import 'package:hontudy/data/services/local/email_service.dart';
import 'package:hontudy/data/services/local/preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/services/local/app_info_service.dart';
import '../data/services/remotes/auth_service.dart';
import '../data/services/remotes/firestore_service.dart';
import '../data/services/remotes/ai_functions_service.dart';

part 'service_providers.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  return AuthService(FirebaseAuth.instance, GoogleSignIn.instance);
}

@Riverpod(keepAlive: true)
FirestoreService firestoreService(Ref ref) {
  return FirestoreService(FirebaseFirestore.instance);
}

const functionsRegion = 'us-central1';

@Riverpod(keepAlive: true)
AiFunctionsService aiFunctionsService(Ref ref) {
  return AiFunctionsService(
    FirebaseFunctions.instanceFor(region: functionsRegion),
  );
}

@Riverpod(keepAlive: true)
Future<PreferenceService> preferencesService(Ref ref) async {
  return PreferenceService(await SharedPreferences.getInstance());
}

@Riverpod(keepAlive: true)
AppInfoService appInfoService(Ref ref) {
  return AppInfoService();
}

@Riverpod(keepAlive: true)
EmailService emailService(Ref ref) {
  return EmailService();
}

@Riverpod(keepAlive: true)
DeviceInfoService deviceInfoService(Ref ref) {
  return DeviceInfoService();
}
