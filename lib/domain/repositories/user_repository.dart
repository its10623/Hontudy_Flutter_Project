import 'package:result_dart/result_dart.dart';

import '../models/user.dart';

abstract class UserRepository {
  AsyncResult<AuthSignInResult> signInWithGoogle();
  AsyncResult<AuthSignInResult> signInWithApple();
  AsyncResult<User> updateDisplayName(String displayName);
  AsyncResult<void> signOut();
  User? get currentUser;
  Stream<User?> authStateChanges();
  AsyncResult<void> deleteAccount();
  AsyncResult<void> deleteUserData();
  AsyncResult<void> reauthenticateWithGoogle();

  /// 재인증 후 Apple 연결 해제에 쓸 토큰을 돌려준다([revokeAppleToken]에 그대로 전달).
  AsyncResult<String> reauthenticateWithApple();
  AsyncResult<void> revokeAppleToken(String token);
  AsyncResult<void> saveTermsAgreement();
  AsyncResult<bool> fetchTermsAgreement();
}
