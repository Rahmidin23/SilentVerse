// lib/utils/shared_prefs.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const _keyUserName = 'userName';
  static const _keyThemeMode = 'themeMode';

  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  static Future<void> saveThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyThemeMode, isDark);
  }

  static Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyThemeMode) ?? true; // default dark theme
  }
}
