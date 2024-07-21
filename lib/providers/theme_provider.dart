import 'package:flutter/material.dart';
import '../services/preference_service.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  final PreferencesService _preferencesService = PreferencesService();

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _isDarkMode = await _preferencesService.getTheme();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _preferencesService.setTheme(_isDarkMode);
    notifyListeners();
  }
}