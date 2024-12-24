import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';
import 'theme_manager.dart';

class ThemeProvider extends ChangeNotifier {
  final List<ThemeModel> _availableThemes = predefinedThemes();
  late ThemeModel _currentTheme;
  bool _isDarkMode = false;

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
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? tertiaryContainer,
    Color? surface,
    Color? onPrimary,
    Color? onSecondary,
    Color? onSurface,
    Color? primaryContainer,
    Color? secondaryContainer,
    Color? onPrimaryContainer,
    Color? onSecondaryContainer,
    Color? onTertiaryContainer,
    TextTheme? textTheme,
  }) {
    final themeIndex = _availableThemes.indexWhere((theme) => theme.name == themeName);
    if (themeIndex != -1) {
      final theme = _availableThemes[themeIndex];
      final updatedTheme = ThemeModel(
        name: theme.name,
        lightTheme: ThemeModel.buildLightTheme(
          primaryContainer: primaryContainer ?? theme.lightTheme.colorScheme.primaryContainer,
          secondaryContainer: secondaryContainer ?? theme.lightTheme.colorScheme.secondaryContainer,
          tertiaryContainer: tertiaryContainer ?? theme.lightTheme.colorScheme.tertiaryContainer,
          onPrimaryContainer: onPrimaryContainer ?? theme.lightTheme.colorScheme.onPrimaryContainer,
          onSecondaryContainer: onSecondaryContainer ?? theme.lightTheme.colorScheme.onSecondaryContainer,
          onTertiaryContainer: onTertiaryContainer ?? theme.lightTheme.colorScheme.onTertiaryContainer,
          textTheme: textTheme ?? theme.lightTheme.textTheme,
        ),
        darkTheme: ThemeModel.buildDarkTheme(
          primaryContainer: primaryContainer ?? theme.darkTheme.colorScheme.primaryContainer,
          secondaryContainer: secondaryContainer ?? theme.darkTheme.colorScheme.secondaryContainer,
          tertiaryContainer: tertiaryContainer ?? theme.darkTheme.colorScheme.tertiaryContainer,
          onPrimaryContainer: onPrimaryContainer ?? theme.darkTheme.colorScheme.onPrimaryContainer,
          onSecondaryContainer: onSecondaryContainer ?? theme.darkTheme.colorScheme.onSecondaryContainer,
          onTertiaryContainer: onTertiaryContainer ?? theme.darkTheme.colorScheme.onTertiaryContainer,
          textTheme: textTheme ?? theme.darkTheme.textTheme,
        ),
      );
      _availableThemes[themeIndex] = updatedTheme;
      notifyListeners();
    }
  }
}