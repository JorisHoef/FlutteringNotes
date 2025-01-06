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

    // Ensure the font family is consistent for the new theme mode
    _currentTheme = ThemeModel(
      name: _currentTheme.name,
      lightTheme: _currentTheme.lightTheme.copyWith(
        textTheme:
            ThemeConstants.ensureFontFamily(_currentTheme.lightTheme.textTheme),
      ),
      darkTheme: _currentTheme.darkTheme.copyWith(
        textTheme:
            ThemeConstants.ensureFontFamily(_currentTheme.darkTheme.textTheme),
      ),
    );

    notifyListeners(); // Notify listeners of the mode change
    await _themeRepository.saveDarkMode(_isDarkMode); // Save mode to storage
  }

  Future<void> switchTheme(String themeName) async {
    // Switch to the selected theme
    final selectedTheme = _availableThemes.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => _currentTheme,
    );

    _currentTheme = ThemeModel(
      name: selectedTheme.name,
      lightTheme: selectedTheme.lightTheme.copyWith(
        textTheme:
            ThemeConstants.ensureFontFamily(selectedTheme.lightTheme.textTheme),
      ),
      darkTheme: selectedTheme.darkTheme.copyWith(
        textTheme:
            ThemeConstants.ensureFontFamily(selectedTheme.darkTheme.textTheme),
      ),
    );

    notifyListeners(); // Notify listeners of the theme change
    await _themeRepository
        .saveSelectedTheme(themeName); // Save selected theme to storage
  }

  Future<void> addTheme(ThemeModel newTheme) async {
    debugPrint("Adding new theme: ${newTheme.name}");

    // Ensure font consistency for the new theme before adding it
    final themeToAdd = ThemeModel(
      name: newTheme.name,
      lightTheme: newTheme.lightTheme.copyWith(
        textTheme:
            ThemeConstants.ensureFontFamily(newTheme.lightTheme.textTheme),
      ),
      darkTheme: newTheme.darkTheme.copyWith(
        textTheme:
            ThemeConstants.ensureFontFamily(newTheme.darkTheme.textTheme),
      ),
    );

    _availableThemes.add(themeToAdd);
    notifyListeners();
    await _themeRepository.saveTheme(themeToAdd); // Save theme to storage
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

      // Ensure font consistency for the updated theme
      final updatedThemeWithFont = ThemeModel(
        name: updatedTheme.name,
        lightTheme: updatedTheme.lightTheme.copyWith(
          textTheme: ThemeConstants.ensureFontFamily(
              updatedTheme.lightTheme.textTheme),
        ),
        darkTheme: updatedTheme.darkTheme.copyWith(
          textTheme:
              ThemeConstants.ensureFontFamily(updatedTheme.darkTheme.textTheme),
        ),
      );

      // Update the in-memory list of themes
      _availableThemes[themeIndex] = updatedThemeWithFont;

      // Save the updated theme to persistent storage
      _themeRepository.saveTheme(updatedThemeWithFont);

      notifyListeners(); // Notify listeners of the changes
      debugPrint("Theme updated and saved: ${updatedThemeWithFont.name}");
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

    // Ensure font family is consistent across the current theme's light and dark text themes
    _currentTheme = ThemeModel(
      name: _currentTheme.name,
      lightTheme: _currentTheme.lightTheme.copyWith(
        textTheme:
            ThemeConstants.ensureFontFamily(_currentTheme.lightTheme.textTheme),
      ),
      darkTheme: _currentTheme.darkTheme.copyWith(
        textTheme:
            ThemeConstants.ensureFontFamily(_currentTheme.darkTheme.textTheme),
      ),
    );

    _isDarkMode = savedDarkModeState ?? false;
    notifyListeners(); // Notify listeners of the loaded data
  }
}
