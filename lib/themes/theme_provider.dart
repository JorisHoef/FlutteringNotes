import 'package:flutter/material.dart';
import 'theme_manager.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme _currentTheme = Themes.blueTheme;

  bool _isDarkMode = false;

  ThemeData get themeData => _isDarkMode ? _currentTheme.darkTheme : _currentTheme.lightTheme;

  void toggleThemeMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void switchTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}