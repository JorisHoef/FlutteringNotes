import 'package:flutter/material.dart';
import 'theme_manager.dart';

class ThemeProvider extends ChangeNotifier {
  final List<ThemeModel> _availableThemes = [
    ThemeModel(
      name: 'Blue Theme',
      lightTheme: ThemeModel.buildLightTheme(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFF90CAF9),
      ),
      darkTheme: ThemeModel.buildDarkTheme(
        primary: Color(0xFF2196F3),
        secondary: Color(0xFF90CAF9),
      ),
    ),
    ThemeModel(
      name: 'Indigo Theme',
      lightTheme: ThemeModel.buildLightTheme(
        primary: Color(0xFF6200EE),
        secondary: Color(0xFFBB86FC),
      ),
      darkTheme: ThemeModel.buildDarkTheme(
        primary: Color(0xFF6200EE),
        secondary: Color(0xFFBB86FC),
      ),
    ),
    ThemeModel(
      name: 'Green Theme',
      lightTheme: ThemeModel.buildLightTheme(
        primary: Color(0xFF4CAF50),
        secondary: Color(0xFFA5D6A7),
      ),
      darkTheme: ThemeModel.buildDarkTheme(
        primary: Color(0xFF4CAF50),
        secondary: Color(0xFFA5D6A7),
      ),
    ),
    ThemeModel(
      name: 'Red Theme',
      lightTheme: ThemeModel.buildLightTheme(
        primary: Color(0xFFF44336),
        secondary: Color(0xFFEF9A9A),
      ),
      darkTheme: ThemeModel.buildDarkTheme(
        primary: Color(0xFFF44336),
        secondary: Color(0xFFEF9A9A),
      ),
    ),
    ThemeModel(
      name: 'Electron-Inspired Theme',
      lightTheme: ThemeModel.buildLightTheme(
        primary: Color(0xFF1C9EB3), // Inspired by Electron, with less green.
        secondary: Color(0xFF82CBD9),
      ),
      darkTheme: ThemeModel.buildDarkTheme(
        primary: Color(0xFF1C9EB3),
        secondary: Color(0xFF82CBD9),
      ),
    ),
  ];

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
}