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
  AsyncResult<void> reauthenticateWithApple();
  AsyncResult<void> saveTermsAgreement();
  AsyncResult<bool> fetchTermsAgreement();
}
