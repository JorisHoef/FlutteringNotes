import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';
import '../models/theme_model.dart';
import '../storage/theme_repository.dart';

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

  ThemeData get themeData =>
      _isDarkMode ? _currentTheme.darkTheme : _currentTheme.lightTheme;

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
    await _themeRepository
        .saveSelectedTheme(themeName); // Save selected theme to storage
  }

  Future<void> addTheme(ThemeModel newTheme) async {
    debugPrint("Adding new theme: ${newTheme.name}");
    _availableThemes.add(newTheme);
    notifyListeners();
    await _themeRepository.saveTheme(newTheme);
  }

  Future<void> deleteTheme(String themeName) async {
    final themeToDelete = _availableThemes.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
    );

    // // Prevent deleting the currently selected theme
    // if (_currentTheme == themeToDelete) {
    //   return;
    // }

    _availableThemes.removeWhere((theme) => theme.name == themeName);
    await _themeRepository.deleteTheme(themeName); // Remove from storage
    notifyListeners(); // Notify listeners after deletion
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

      // Update the theme with new color schemes
      final updatedTheme = ThemeModel(
        name: theme.name,
        lightTheme: theme.lightTheme.copyWith(colorScheme: lightScheme),
        darkTheme: theme.darkTheme.copyWith(colorScheme: darkScheme),
      );

      // Update the in-memory list of themes
      _availableThemes[themeIndex] = updatedTheme;

      // Save the updated theme to persistent storage
      _themeRepository.saveTheme(updatedTheme);

      notifyListeners(); // Notify listeners of the changes
      debugPrint("Theme updated and saved: ${updatedTheme.name}");
    }
  }

  Future<void> _loadThemeFromStorage() async {
    // Get selected theme name and dark mode state from repository
    final savedThemeName = await _themeRepository.fetchSelectedTheme();
    final savedDarkModeState = await _themeRepository.fetchDarkMode();

    // Load available themes from repository
    final storedThemes = await _themeRepository.fetchThemes();

    if (storedThemes.isEmpty && _availableThemes.isEmpty) {
      // Fix to not overwrite if already present
      // If no themes are saved, initialize with predefined themes
      for (final theme in predefinedThemes()) {
        await _themeRepository.saveTheme(theme);
      }
      _availableThemes.clear(); // Populate with predefined themes
      _availableThemes.addAll(predefinedThemes());
    } else if (storedThemes.isNotEmpty) {
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
