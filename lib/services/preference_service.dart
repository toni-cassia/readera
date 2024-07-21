import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String SORT_KEY = 'sort_order';
  static const String THEME_KEY = 'is_dark_mode';

  Future<void> setSortOrder(String order) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SORT_KEY, order);
  }

  Future<String> getSortOrder() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SORT_KEY) ?? 'title';
  }

  Future<void> setTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_KEY, isDarkMode);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_KEY) ?? false;
  }
}