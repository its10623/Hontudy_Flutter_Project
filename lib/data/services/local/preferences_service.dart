import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_service.g.dart';

class PreferenceService {
  final SharedPreferences _prefs;

  PreferenceService(this._prefs);

  Future<bool> getPushNotificationEnabled() async {
    return _prefs.getBool('push_notification_enabled') ?? true;
  }

  Future<void> setPushNotificationEnabled(bool value) async {
    await _prefs.setBool('push_notification_enabled', value);
  }
}

@riverpod
Future<PreferenceService> preferencesService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return PreferenceService(prefs);
}
