import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  bool _googleSignInInitialized = false;

  AuthService(this._firebaseAuth, this._googleSignIn);

  Future<UserCredential> signInWithGoogle() async {
    final credential = await _googleCredential();
    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithApple() async {
    if (Platform.isAndroid) {
      final userCredential = await _firebaseAuth.signInWithProvider(
        _appleProvider(),
      );
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await _reorderKoreanAppleName();
      }
      return userCredential;
    }
    final apple = await _appleCredential();
    final userCredential = await _firebaseAuth.signInWithCredential(
      apple.credential,
    );
    await _saveAppleNameIfMissing(apple.fullName);
    return userCredential;
  }

  Future<void> updateDisplayName(String displayName) async {
    await _firebaseAuth.currentUser?.updateDisplayName(displayName);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser?.delete();
  }

  Future<void> reauthenticateWithGoogle() async {
    final credential = await _googleCredential();
    await _firebaseAuth.currentUser?.reauthenticateWithCredential(credential);
  }

  /// 재인증하고, 탈퇴 시 Apple 연결을 끊는 데 쓸 토큰을 돌려줌
  Future<String> reauthenticateWithApple() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw StateError('로그인된 사용자가 없어 재인증할 수 없음');

    if (Platform.isAndroid) {
      final userCredential = await user.reauthenticateWithProvider(
        _appleProvider(),
      );
      final accessToken = userCredential.credential?.accessToken;
      if (accessToken == null) {
        throw StateError('Apple 재인증 결과에 access token이 없음');
      }
      return accessToken;
    }
    final apple = await _appleCredential();
    await user.reauthenticateWithCredential(apple.credential);
    return apple.authorizationCode;
  }

  /// Apple ID 설정의 "Apple로 로그인" 연결을 끊기
  Future<void> revokeAppleToken(String token) async {
    if (Platform.isAndroid) {
      await _firebaseAuth.revokeAccessToken(token);
      return;
    }
    await _firebaseAuth.revokeTokenWithAuthorizationCode(token);
  }

  Future<OAuthCredential> _googleCredential() async {
    if (!_googleSignInInitialized) {
      await _googleSignIn.initialize();
      _googleSignInInitialized = true;
    }
    final account = await _googleSignIn.authenticate();
    final idToken = account.authentication.idToken;
    return GoogleAuthProvider.credential(idToken: idToken);
  }

  AppleAuthProvider _appleProvider() {
    return AppleAuthProvider()
      ..addScope('email')
      ..addScope('name');
  }

  Future<
    ({OAuthCredential credential, String? fullName, String authorizationCode})
  >
  _appleCredential() async {
    final rawNonce = _generateNonce();
    final hashedNonce = _sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final credential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    final fullName = _joinAppleName(
      givenName: appleCredential.givenName,
      familyName: appleCredential.familyName,
    );
    return (
      credential: credential,
      fullName: fullName,
      authorizationCode: appleCredential.authorizationCode,
    );
  }

  Future<void> _saveAppleNameIfMissing(String? fullName) async {
    final user = _firebaseAuth.currentUser;
    if (user == null || fullName == null) return;
    if (user.displayName?.isNotEmpty ?? false) return;
    await user.updateDisplayName(fullName);
  }

  Future<void> _reorderKoreanAppleName() async {
    final user = _firebaseAuth.currentUser;
    final displayName = user?.displayName?.trim();
    if (user == null || displayName == null) return;

    final match = RegExp(r'^([가-힣]+) ([가-힣]+)$').firstMatch(displayName);
    if (match == null) return;
    await user.updateDisplayName('${match[2]}${match[1]}');
  }

  String? _joinAppleName({String? givenName, String? familyName}) {
    final given = givenName?.trim() ?? '';
    final family = familyName?.trim() ?? '';
    if (given.isEmpty && family.isEmpty) return null;

    final isKorean = RegExp(r'[가-힣]').hasMatch('$family$given');
    if (isKorean) return '$family$given';
    return [given, family].where((part) => part.isNotEmpty).join(' ');
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
