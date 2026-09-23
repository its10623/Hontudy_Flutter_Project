
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../domain/models/user.dart';

class UserMapper {
  static User toDomain(firebase_auth.User firebaseUser) {
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      photoUrl: firebaseUser.photoURL,
      authProvider: _authProviderFrom(firebaseUser),
    );
  }

  static AuthProvider _authProviderFrom(firebase_auth.User firebaseUser) {
    final providerId = firebaseUser.providerData.isNotEmpty
        ? firebaseUser.providerData.first.providerId
        : '';
    if (providerId.contains('apple')) return AuthProvider.apple;
    return AuthProvider.google;
  }
}