import 'package:hontudy/domain/models/diagnosis_profile.dart';
import 'package:hontudy/domain/models/user.dart';

class ProfileState {
  final User? user;
  final DiagnosisProfile? diagnosis;

  const ProfileState({required this.user, required this.diagnosis});
}
