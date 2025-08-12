import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static final AppPrefs _instance = AppPrefs._internal();
  SharedPreferences? _prefs;

  // Private constructor for [Singleton]
  AppPrefs._internal();

  // Getter for [Singleton]
  static AppPrefs get instance => _instance;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Preference keys
  static const String fcmToken = 'fcm_token';

  // Save FCM token
  Future<void> setFcmToken(String token) async {
    await _prefs?.setString(fcmToken, token);
  }

  String? getFcmToken() {
    return _prefs?.getString(fcmToken);
  }

  //! Clear all preferences
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
