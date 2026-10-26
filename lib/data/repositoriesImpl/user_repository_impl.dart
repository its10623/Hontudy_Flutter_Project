import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignInException, GoogleSignInExceptionCode;
import 'package:hontudy/domain/exceptions.dart';
import 'package:hontudy/domain/repositories/user_repository.dart';
import 'package:hontudy/domain/models/user.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart'
    show AuthorizationErrorCode, SignInWithAppleAuthorizationException;

import '../result_guard.dart';
import '../services/remotes/auth_service.dart';
import '../services/remotes/firestore_service.dart';
import '../user_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthService _auth;
  final FirestoreService _firestoreService;

  UserRepositoryImpl({
    required this._auth,
    required this._firestoreService,
  });

  Future<T> _throwIfCancelled<T>(Future<T> Function() authCall) async {
    try {
      return await authCall();
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw SignInCancelledException();
      }
      rethrow;
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw SignInCancelledException();
      }
      rethrow;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'web-context-canceled') {
        throw SignInCancelledException();
      }
      rethrow;
    }
  }

  @override
  AsyncResult<AuthSignInResult> signInWithGoogle() {
    return guardAsync(() async {
      final credential = await _throwIfCancelled(_auth.signInWithGoogle);
      final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
      final user = UserMapper.toDomain(credential.user!);
      return (user: user, isNewUser: isNewUser);
    });
  }

  @override
  AsyncResult<AuthSignInResult> signInWithApple() {
    return guardAsync(() async {
      final credential = await _throwIfCancelled(_auth.signInWithApple);
      final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
      final user = UserMapper.toDomain(_auth.currentUser!);
      return (user: user, isNewUser: isNewUser);
    });
  }

  @override
  AsyncResult<User> updateDisplayName(String displayName) {
    return guardAsync(() async {
      await _auth.updateDisplayName(displayName);
      final firebaseUser = _auth.currentUser;
      return UserMapper.toDomain(firebaseUser!);
    });
  }

  @override
  AsyncResult<void> signOut() {
    return guardAsync(() async {
      await _auth.signOut();
      return unit;
    });
  }

  @override
  User? get currentUser {
    final firebaseUser = _auth.currentUser;
    return firebaseUser == null ? null : UserMapper.toDomain(firebaseUser);
  }

  @override
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges().map(
      (firebaseUser) =>
          firebaseUser == null ? null : UserMapper.toDomain(firebaseUser),
    );
  }

  @override
  AsyncResult<void> deleteAccount() {
    return guardAsync(() async {
      await _auth.deleteAccount();
      return unit;
    });
  }

  @override
  AsyncResult<void> deleteUserData() {
    return guardAsync(() async {
      await _firestoreService.deleteUserDocument(_auth.requireUid());
      return unit;
    });
  }

  @override
  AsyncResult<void> reauthenticateWithGoogle() {
    return guardAsync(() async {
      await _throwIfCancelled(_auth.reauthenticateWithGoogle);
      return unit;
    });
  }

  @override
  AsyncResult<String> reauthenticateWithApple() {
    return guardAsync(
      () => _throwIfCancelled(_auth.reauthenticateWithApple),
    );
  }

  @override
  AsyncResult<void> revokeAppleToken(String token) {
    return guardAsync(() async {
      await _auth.revokeAppleToken(token);
      return unit;
    });
  }

  @override
  AsyncResult<void> saveTermsAgreement() {
    return guardAsync(() async {
      await _firestoreService.saveTermsAgreement(_auth.requireUid());
      return unit;
    });
  }

  @override
  AsyncResult<bool> fetchTermsAgreement() {
    return guardAsync(
      () => _firestoreService.fetchTermsAgreement(_auth.requireUid()),
    );
  }
}
