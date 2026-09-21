
import 'package:result_dart/result_dart.dart';

import '../models/user.dart';

abstract class UserRepository {
  AsyncResult<AuthSignInResult> signInWithGoogle();
  AsyncResult<AuthSignInResult> signInWithApple();
  AsyncResult<User> updateDisplayName(String displayName);
  AsyncResult<void> signOut();
  AsyncResult<User> fetchCurrentUser();
  Stream<User?> authStateChanges();
  AsyncResult<void> deleteAccount();
  AsyncResult<void> reauthenticateWithGoogle();
  AsyncResult<void> reauthenticateWithApple();
}