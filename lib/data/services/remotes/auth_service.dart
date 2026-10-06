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
      // Firebase가 "이름 성"으로 저장한 신규 가입자 이름을 한국식으로 맞춤
      final parts = userCredential.user?.displayName?.split(' ');
      if ((userCredential.additionalUserInfo?.isNewUser ?? false) &&
          parts?.length == 2) {
        await _saveName(given: parts![0], family: parts[1]);
      }
      return userCredential;
    }
    final (apple, credential) = await _appleCredential();
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    await _saveName(given: apple.givenName, family: apple.familyName);
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
    final (apple, credential) = await _appleCredential();
    await user.reauthenticateWithCredential(credential);
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

  Future<(AuthorizationCredentialAppleID, OAuthCredential)>
  _appleCredential() async {
    final rawNonce = _generateNonce();
    final apple = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: _sha256ofString(rawNonce),
    );
    final credential = OAuthProvider('apple.com').credential(
      idToken: apple.identityToken,
      rawNonce: rawNonce,
    );
    return (apple, credential);
  }

  // Apple은 이름을 최초 로그인 때만 준다 한글 이름은 성+이름으로 붙여 저장
  Future<void> _saveName({String? given, String? family}) async {
    final user = _firebaseAuth.currentUser;
    final g = given?.trim() ?? '';
    final f = family?.trim() ?? '';
    if (user == null || (g.isEmpty && f.isEmpty)) return;

    final isKorean = RegExp(r'[가-힣]').hasMatch('$f$g');
    await user.updateDisplayName(isKorean ? '$f$g' : '$g $f'.trim());
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
