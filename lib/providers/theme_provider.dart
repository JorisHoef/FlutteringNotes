import 'package:flutter/material.dart';
import 'package:fluttering_notes/storage/theme_repository.dart';
import '../constants/theme_constants.dart';
import '../models/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeRepository _themeRepository;

  final List<ThemeModel> _availableThemes = [];
  late ThemeModel _currentTheme;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeModel get currentTheme => _currentTheme;

  ThemeProvider(this._themeRepository) {
    // Set the first theme as default temporarily
    _currentTheme = predefinedThemes().first;

    // Load themes and settings from repository
    _loadThemeFromStorage();
  }

  ThemeData get themeData => _isDarkMode ? _currentTheme.darkTheme : _currentTheme.lightTheme;

  List<ThemeModel> get availableThemes => _availableThemes;

  Future<void> toggleThemeMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notify listeners of the mode change
    await _themeRepository.saveDarkMode(_isDarkMode); // Save mode to storage
  }

  Future<void> switchTheme(String themeName) async {
    final selectedTheme = _availableThemes.firstWhere(
          (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
    );
    _currentTheme = selectedTheme;
    notifyListeners(); // Notify listeners of the theme change
    await _themeRepository.saveSelectedTheme(themeName); // Save selected theme to storage
  }

  Future<void> addTheme(ThemeModel newTheme) async {
    _availableThemes.add(newTheme);
    notifyListeners(); // Notify listeners of the new theme addition
    await _themeRepository.saveTheme(newTheme); // Save to storage
  }

  Future<void> deleteTheme(String themeName) async {
    final themeToDelete = _availableThemes.firstWhere(
          (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
    );

    // Prevent deleting the currently selected theme
    if (_currentTheme == themeToDelete) {
      return;
    }

    _availableThemes.removeWhere((theme) => theme.name == themeName);
    await _themeRepository.deleteTheme(themeName); // Remove from storage
    notifyListeners(); // Notify listeners after deletion
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
      notifyListeners(); // Notify changes
    }
  }

  Future<void> _loadThemeFromStorage() async {
    // Get selected theme name and dark mode state from repository
    final savedThemeName = await _themeRepository.fetchSelectedTheme();
    final savedDarkModeState = await _themeRepository.fetchDarkMode();

    // Load available themes from repository
    final storedThemes = await _themeRepository.fetchThemes();

    if (storedThemes.isEmpty) {
      // If no themes are saved, initialize with predefined themes
      for (final theme in predefinedThemes()) {
        await _themeRepository.saveTheme(theme);
      }
      _availableThemes.clear();
      _availableThemes.addAll(predefinedThemes());
    } else {
      // Use stored themes
      _availableThemes.clear();
      _availableThemes.addAll(storedThemes);
    }

    // Set the current theme and dark mode state
    if (savedThemeName != null) {
      _currentTheme = _availableThemes.firstWhere(
            (theme) => theme.name == savedThemeName,
        orElse: () => _availableThemes.first,
      );
    } else {
      _currentTheme = _availableThemes.first;
    }

    _isDarkMode = savedDarkModeState ?? false;

    notifyListeners(); // Notify listeners of the loaded data
  }
}