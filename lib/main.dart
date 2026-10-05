import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hontudy/di/service_providers.dart';
import 'package:hontudy/firebase_options.dart';
import 'package:hontudy/presentation/core/theme/theme.dart';
import 'package:hontudy/presentation/views/pages/splash_page.dart';

/// `flutter run --dart-define=USE_FUNCTIONS_EMULATOR=true`로 실행하면
/// 배포된 함수 대신 로컬 Firebase 에뮬레이터의 함수를 호출한다.
const _useFunctionsEmulator = bool.fromEnvironment('USE_FUNCTIONS_EMULATOR');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _activateAppCheck();
  if (_useFunctionsEmulator) _connectFunctionsEmulator();
  runApp(const ProviderScope(retry: _noRetry, child: MyApp()));
}

/// AI 프록시 함수는 App Check 토큰이 없으면 거절한다.
/// 디버그 빌드는 디버그 제공자(로그에 찍히는 디버그 토큰을 콘솔에 등록),
/// 릴리스 빌드는 Play Integrity / App Attest(DeviceCheck 대체)를 쓴다.
Future<void> _activateAppCheck() {
  return FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? const AndroidDebugProvider()
        : const AndroidPlayIntegrityProvider(),
    providerApple: kDebugMode
        ? const AppleDebugProvider()
        : const AppleAppAttestWithDeviceCheckFallbackProvider(),
  );
}

void _connectFunctionsEmulator() {
  // 안드로이드 에뮬레이터에서 호스트 PC의 localhost는 10.0.2.2다.
  final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFunctions.instanceFor(region: functionsRegion)
      .useFunctionsEmulator(host, 5001);
}

Duration? _noRetry(int retryCount, Object error) => null;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const Scaffold(body: SplashPage()),
    );
  }
}
