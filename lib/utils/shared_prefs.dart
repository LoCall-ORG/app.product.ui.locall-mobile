import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static final SharedPrefs _instance = SharedPrefs._();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  T? getValue<T>(String key) {
    return _prefs?.get(key) as T?;
  }

  Future<bool> setValue<T>(String key, T value) async {
    if (value is String) {
      return await _prefs?.setString(key, value) ?? Future.value(false);
    } else if (value is int) {
      return await _prefs?.setInt(key, value) ?? Future.value(false);
    } else if (value is double) {
      return await _prefs?.setDouble(key, value) ?? Future.value(false);
    } else if (value is bool) {
      return await _prefs?.setBool(key, value) ?? Future.value(false);
    } else if (value is List<String>) {
      return await _prefs?.setStringList(key, value) ?? Future.value(false);
    }
    throw Exception("Invalid type");
  }

  Future<bool> removeValue(String key) async {
    return await _prefs?.remove(key) ?? Future.value(false);
  }

  static String selectedLanguage = "language";
}
