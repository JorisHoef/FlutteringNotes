import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';
import 'theme_manager.dart';

class ThemeProvider extends ChangeNotifier {
  final List<ThemeModel> _availableThemes = predefinedThemes();
  late ThemeModel _currentTheme;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeModel get currentTheme => _currentTheme;

  ThemeProvider() {
    _currentTheme = _availableThemes.first;
  }

  ThemeData get themeData =>
      _isDarkMode ? _currentTheme.darkTheme : _currentTheme.lightTheme;

  List<ThemeModel> get availableThemes => _availableThemes;

  void toggleThemeMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void switchTheme(String themeName) {
    var selectedTheme = _availableThemes.firstWhere(
          (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
    );
    _currentTheme = selectedTheme;
    notifyListeners();
  }

  void addTheme(ThemeModel newTheme) {
    _availableThemes.add(newTheme);
    notifyListeners();
  }

  void customizeTheme({
    required String themeName,
    required ColorScheme lightScheme,
    required ColorScheme darkScheme,
  }) {
    final themeIndex = _availableThemes.indexWhere((theme) => theme.name == themeName);
    if (themeIndex != -1) {
      final theme = _availableThemes[themeIndex];
      final updatedTheme = ThemeModel(
        name: theme.name,
        lightTheme: theme.lightTheme.copyWith(colorScheme: lightScheme),
        darkTheme: theme.darkTheme.copyWith(colorScheme: darkScheme),
      );
      _availableThemes[themeIndex] = updatedTheme;
      notifyListeners();
    }
  }
}