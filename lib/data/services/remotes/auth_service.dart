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
      return _firebaseAuth.signInWithProvider(_appleProvider());
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

  Future<void> reauthenticateWithApple() async {
    if (Platform.isAndroid) {
      await _firebaseAuth.currentUser?.reauthenticateWithProvider(
        _appleProvider(),
      );
      return;
    }
    final apple = await _appleCredential();
    await _firebaseAuth.currentUser?.reauthenticateWithCredential(
      apple.credential,
    );
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

  Future<({OAuthCredential credential, String? fullName})>
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
    return (credential: credential, fullName: fullName);
  }

  Future<void> _saveAppleNameIfMissing(String? fullName) async {
    final user = _firebaseAuth.currentUser;
    if (user == null || fullName == null) return;
    if (user.displayName?.isNotEmpty ?? false) return;
    await user.updateDisplayName(fullName);
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
