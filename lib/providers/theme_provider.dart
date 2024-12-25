import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/theme_constants.dart';
import '../models/theme_model.dart';
import '../storage/theme_repository.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeRepository _themeRepository = ThemeRepository();
  final List<ThemeModel> _availableThemes = [];
  late ThemeModel _currentTheme;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeModel get currentTheme => _currentTheme;

  ThemeProvider() {
    _currentTheme = predefinedThemes().first; // Set a default temporary theme
    _loadThemeFromPrefs(); // Load and restore themes/settings from storage
  }

  ThemeData get themeData =>
      _isDarkMode ? _currentTheme.darkTheme : _currentTheme.lightTheme;

  List<ThemeModel> get availableThemes => _availableThemes;

  Future<void> toggleThemeMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await _saveThemeToPrefs(); // Save the updated dark mode setting
  }

  Future<void> switchTheme(String themeName) async {
    final selectedTheme = _availableThemes.firstWhere(
          (theme) => theme.name == themeName,
      orElse: () => _currentTheme, // Default to current theme if no match found
    );
    _currentTheme = selectedTheme;
    notifyListeners();
    await _saveThemeToPrefs(); // Save the updated theme selection
  }

  void addTheme(ThemeModel newTheme) {
    _availableThemes.add(newTheme);
    notifyListeners();
  }

  void deleteTheme(String themeName) {
    final themeToDelete = _availableThemes.firstWhere(
          (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
    );

    if (_currentTheme == themeToDelete) {
      // Prevent deleting the currently selected theme
      return;
    }

    _availableThemes.removeWhere((theme) => theme.name == themeName);
    notifyListeners();
  }

  void customizeTheme({
    required String themeName,
    required ColorScheme lightScheme,
    required ColorScheme darkScheme,
  }) {
    final themeIndex =
    _availableThemes.indexWhere((theme) => theme.name == themeName);
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

  Future<void> _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentTheme', _currentTheme.name);
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('currentTheme');
    final darkMode = prefs.getBool('isDarkMode') ?? false;

    final storedThemes = await _themeRepository.fetchThemes();

    if (storedThemes.isEmpty) {
      for (final theme in predefinedThemes()) {
        await _themeRepository.saveTheme(theme);
      }
      _availableThemes.clear();
      _availableThemes.addAll(predefinedThemes());
    } else {
      _availableThemes.clear();
      _availableThemes.addAll(storedThemes);
    }

    if (themeName != null) {
      final savedTheme = _availableThemes.firstWhere(
            (theme) => theme.name == themeName,
        orElse: () => _availableThemes.first,
      );
      _currentTheme = savedTheme;
    } else {
      _currentTheme = _availableThemes.first;
    }

    _isDarkMode = darkMode;
    notifyListeners();
  }
}