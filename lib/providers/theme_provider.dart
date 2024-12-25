import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/theme_constants.dart';
import '../models/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  final List<ThemeModel> _availableThemes = predefinedThemes();
  late ThemeModel _currentTheme;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeModel get currentTheme => _currentTheme;

  ThemeProvider() {
    _currentTheme = _availableThemes.first; // Default value during initialization
    _loadThemeFromPrefs(); // Load the saved preferences
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
    var selectedTheme = _availableThemes.firstWhere(
          (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
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

  // Save the current theme and mode to SharedPreferences
  Future<void> _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentTheme', _currentTheme.name);
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  // Load the saved theme and mode from SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('currentTheme'); // Get stored theme name
    final darkMode = prefs.getBool('isDarkMode') ?? false; // Get stored mode

    if (themeName != null) {
      // Find the matching theme by name from the saved preferences
      final savedTheme = _availableThemes.firstWhere(
            (theme) => theme.name == themeName,
        // If the saved theme is no longer available, fallback to a default theme
        orElse: () => _availableThemes.first,
      );
      _currentTheme = savedTheme; // Set the last selected (or fallback) theme
    } else {
      _currentTheme = _availableThemes.first; // Default fallback if no theme saved
    }

    _isDarkMode = darkMode; // Restore the dark mode preference
    notifyListeners(); // Notify UI about the restored settings
  }
}