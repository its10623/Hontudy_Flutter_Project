import 'package:hontudy/domain/repositories/user_repository.dart';
import 'package:hontudy/domain/models/user.dart';
import 'package:result_dart/result_dart.dart';

import '../result_guard.dart';
import '../services/remotes/auth_service.dart';
import '../services/remotes/firestore_service.dart';
import '../user_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  UserRepositoryImpl({
    required this._authService,
    required this._firestoreService,
  });

  String _requireUid() => _authService.currentUser!.uid;

  @override
  AsyncResult<AuthSignInResult> signInWithGoogle() {
    return guardAsync(() async {
      final credential = await _authService.signInWithGoogle();
      final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
      final user = UserMapper.toDomain(credential.user!);
      return (user: user, isNewUser: isNewUser);
    });
  }

  @override
  AsyncResult<AuthSignInResult> signInWithApple() {
    return guardAsync(() async {
      final credential = await _authService.signInWithApple();
      final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
      final user = UserMapper.toDomain(credential.user!);
      return (user: user, isNewUser: isNewUser);
    });
  }

  @override
  AsyncResult<User> updateDisplayName(String displayName) {
    return guardAsync(() async {
      await _authService.updateDisplayName(displayName);
      final firebaseUser = _authService.currentUser;
      return UserMapper.toDomain(firebaseUser!);
    });
  }

  @override
  AsyncResult<void> signOut() {
    return guardAsync(() async {
      await _authService.signOut();
      return unit;
    });
  }

  @override
  AsyncResult<User> fetchCurrentUser() {
    return guardAsync(() async {
      final firebaseUser = _authService.currentUser;
      return UserMapper.toDomain(firebaseUser!);
    });
  }

  @override
  Stream<User?> authStateChanges() {
    return _authService.authStateChanges().map(
      (firebaseUser) =>
          firebaseUser == null ? null : UserMapper.toDomain(firebaseUser),
    );
  }

  @override
  AsyncResult<void> deleteAccount() {
    return guardAsync(() async {
      await _authService.deleteAccount();
      return unit;
    });
  }

  @override
  AsyncResult<void> reauthenticateWithGoogle() {
    return guardAsync(() async {
      await _authService.reauthenticateWithGoogle();
      return unit;
    });
  }

  @override
  AsyncResult<void> reauthenticateWithApple() {
    return guardAsync(() async {
      await _authService.reauthenticateWithApple();
      return unit;
    });
  }

  @override
  AsyncResult<void> saveTermsAgreement() {
    return guardAsync(() async {
      await _firestoreService.saveTermsAgreement(_requireUid());
      return unit;
    });
  }

  @override
  AsyncResult<bool> fetchTermsAgreement() {
    return guardAsync(() => _firestoreService.fetchTermsAgreement(_requireUid()));
  }
}
