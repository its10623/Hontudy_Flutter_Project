
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final AuthProvider authProvider;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.authProvider,
  });
}

enum AuthProvider { google, apple }