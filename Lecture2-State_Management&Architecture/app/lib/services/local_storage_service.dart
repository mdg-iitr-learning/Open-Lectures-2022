import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late LocalStorageService _instance;
  static late SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();

    return _instance;
  }

  // Keys
  static const String isLoggedInKey = 'is_logged_in_key';

  // Utils
  dynamic _getFromDisk(String key) {
    final value = _preferences.get(key);
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    } else if (content is bool) {
      _preferences.setBool(key, content);
    } else if (content is int) {
      _preferences.setInt(key, content);
    } else if (content is double) {
      _preferences.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  bool get isLoggedIn => _getFromDisk(isLoggedInKey) ?? false;

  set isLoggedIn(bool val) {
    _saveToDisk(isLoggedInKey, val);
  }
}
