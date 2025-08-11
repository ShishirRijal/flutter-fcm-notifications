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

  // Generic methods
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  //! Clear all preferences
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
