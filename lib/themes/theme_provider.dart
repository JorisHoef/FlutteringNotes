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
  }) {
    final themeIndex = _availableThemes.indexWhere((theme) => theme.name == themeName);
    if (themeIndex != -1) {
      final theme = _availableThemes[themeIndex];
      final updatedTheme = ThemeModel(
        name: theme.name,
        lightTheme: ThemeModel.buildLightTheme(
          primary: primary ?? theme.lightTheme.colorScheme.primary,
          secondary: secondary ?? theme.lightTheme.colorScheme.secondary,
          tertiary: tertiary ?? theme.lightTheme.colorScheme.tertiary,
          tertiaryContainer: tertiaryContainer ?? theme.lightTheme.colorScheme.tertiaryContainer,
          surface: surface ?? theme.lightTheme.colorScheme.surface,
          onPrimary: onPrimary ?? theme.lightTheme.colorScheme.onPrimary,
          onSecondary: onSecondary ?? theme.lightTheme.colorScheme.onSecondary,
          onSurface: onSurface ?? theme.lightTheme.colorScheme.onSurface,
          primaryContainer: primaryContainer ?? theme.lightTheme.colorScheme.primaryContainer,
          secondaryContainer: secondaryContainer ?? theme.lightTheme.colorScheme.secondaryContainer,
          onPrimaryContainer: onPrimaryContainer ?? theme.lightTheme.colorScheme.onPrimaryContainer,
          onSecondaryContainer: onSecondaryContainer ?? theme.lightTheme.colorScheme.onSecondaryContainer,
        ),
        darkTheme: ThemeModel.buildDarkTheme(
          primary: primary ?? theme.darkTheme.colorScheme.primary,
          secondary: secondary ?? theme.darkTheme.colorScheme.secondary,
          tertiary: tertiary ?? theme.darkTheme.colorScheme.tertiary,
          tertiaryContainer: tertiaryContainer ?? theme.darkTheme.colorScheme.tertiaryContainer,
          surface: surface ?? theme.darkTheme.colorScheme.surface,
          onPrimary: onPrimary ?? theme.darkTheme.colorScheme.onPrimary,
          onSecondary: onSecondary ?? theme.darkTheme.colorScheme.onSecondary,
          onSurface: onSurface ?? theme.darkTheme.colorScheme.onSurface,
          primaryContainer: primaryContainer ?? theme.darkTheme.colorScheme.primaryContainer,
          secondaryContainer: secondaryContainer ?? theme.darkTheme.colorScheme.secondaryContainer,
          onPrimaryContainer: onPrimaryContainer ?? theme.darkTheme.colorScheme.onPrimaryContainer,
          onSecondaryContainer: onSecondaryContainer ?? theme.darkTheme.colorScheme.onSecondaryContainer,
        ),
      );
      _availableThemes[themeIndex] = updatedTheme;
      notifyListeners();
    }
  }
}