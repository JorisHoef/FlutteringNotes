import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/theme_model.dart';
import 'theme_repository.dart';

class LocalThemeRepository extends ThemeRepository {
  final String _themesKey = "customThemes";
  final String _selectedThemeKey = "selectedTheme";
  final String _darkModeKey = "isDarkMode";

  // Fetch all themes
  @override
  Future<List<ThemeModel>> fetchThemes() async {
    final prefs = await SharedPreferences.getInstance();
    final themesJson = prefs.getStringList(_themesKey);

    // Return an empty list if no themes are stored
    if (themesJson == null) return [];

    // Safely iterate through themesJson and decode each string
    return themesJson
        .map((themeJson) {
          try {
            final decoded = json.decode(themeJson) as Map<String, dynamic>;

            // Build the ThemeModel from decoded JSON
            return ThemeModel(
              name: decoded['name'],
              lightTheme: ThemeData(
                colorScheme: _colorSchemeFromJson(
                    decoded['lightTheme'] as Map<String, dynamic>,
                    Brightness.light),
              ),
              darkTheme: ThemeData(
                colorScheme: _colorSchemeFromJson(
                    decoded['darkTheme'] as Map<String, dynamic>,
                    Brightness.dark),
              ),
            );
          } catch (e) {
            // Handle invalid JSON gracefully (logs or debugging purposes)
            debugPrint('Error decoding themeJson: $themeJson - $e');
            return null; // Skip invalid entries
          }
        })
        .whereType<ThemeModel>()
        .toList(); // Remove nulls and return valid themes
  }

  // Save or update a theme
  @override
  Future<void> saveTheme(ThemeModel theme) async {
    final prefs = await SharedPreferences.getInstance();

    // Fetch themes already stored
    final themes = await fetchThemes();
    debugPrint("Themes before saving: ${themes.map((t) => t.name).toList()}");

    // Remove duplicate name and update the theme
    final updatedThemes = [
      for (final storedTheme in themes)
        if (storedTheme.name == theme.name) theme else storedTheme,
      if (!themes.any((storedTheme) => storedTheme.name == theme.name)) theme,
    ];

    debugPrint(
        "Themes after updating: ${updatedThemes.map((t) => t.name).toList()}");

    // Serialize updated themes as JSON strings
    final themesJson = updatedThemes.map((t) {
      return json.encode({
        'name': t.name,
        'lightTheme': _colorSchemeToJson(t.lightTheme.colorScheme),
        'darkTheme': _colorSchemeToJson(t.darkTheme.colorScheme),
      });
    }).toList();

    await prefs.setStringList(_themesKey, themesJson);

    // Debugging after saving
    final storedThemesJson = prefs.getStringList(_themesKey);
    debugPrint("Stored themes in SharedPreferences: $storedThemesJson");
  }

  // Delete a theme by name
  @override
  Future<void> deleteTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    final themes = await fetchThemes();

    // Remove the theme with the specified name
    final updatedThemes = themes.where((t) => t.name != themeName).toList();

    // Save the updated list of themes
    final themesJson = updatedThemes.map((t) {
      return json.encode({
        'name': t.name,
        'lightTheme': _colorSchemeToJson(t.lightTheme.colorScheme),
        'darkTheme': _colorSchemeToJson(t.darkTheme.colorScheme),
      });
    }).toList();

    await prefs.setStringList(_themesKey, themesJson);
  }

  // Save dark mode preference
  @override
  Future<void> saveDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, isDarkMode);
  }

  // Fetch dark mode preference
  @override
  Future<bool?> fetchDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey); // Returns true, false, or null
  }

  // Save the selected theme name
  @override
  Future<void> saveSelectedTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedThemeKey, themeName);
  }

  // Fetch the selected theme name
  @override
  Future<String?> fetchSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedThemeKey);
  }

  // Serialize ColorScheme to JSON for storage
  Map<String, dynamic> _colorSchemeToJson(ColorScheme scheme) {
    return {
      'primary': _colorToHex(scheme.primary),
      'onPrimary': _colorToHex(scheme.onPrimary),
      'primaryContainer': _colorToHex(scheme.primaryContainer),
      'onPrimaryContainer': _colorToHex(scheme.onPrimaryContainer),
      'secondary': _colorToHex(scheme.secondary),
      'onSecondary': _colorToHex(scheme.onSecondary),
      'secondaryContainer': _colorToHex(scheme.secondaryContainer),
      'onSecondaryContainer': _colorToHex(scheme.onSecondaryContainer),
      'tertiary': _colorToHex(scheme.tertiary),
      'onTertiary': _colorToHex(scheme.onTertiary),
      'tertiaryContainer': _colorToHex(scheme.tertiaryContainer),
      'onTertiaryContainer': _colorToHex(scheme.onTertiaryContainer),
      'error': _colorToHex(scheme.error),
      'onError': _colorToHex(scheme.onError),
      'surface': _colorToHex(scheme.surface),
      'onSurface': _colorToHex(scheme.onSurface),
      'background': _colorToHex(scheme.background),
      'onBackground': _colorToHex(scheme.onBackground),
    };
  }

  // Deserialize ColorScheme from JSON
  ColorScheme _colorSchemeFromJson(
      Map<String, dynamic> json, Brightness brightness) {
    return ColorScheme(
      primary: _colorFromHex(json['primary']),
      onPrimary: _colorFromHex(json['onPrimary']),
      primaryContainer: _colorFromHex(json['primaryContainer']),
      onPrimaryContainer: _colorFromHex(json['onPrimaryContainer']),
      secondary: _colorFromHex(json['secondary']),
      onSecondary: _colorFromHex(json['onSecondary']),
      secondaryContainer: _colorFromHex(json['secondaryContainer']),
      onSecondaryContainer: _colorFromHex(json['onSecondaryContainer']),
      tertiary: _colorFromHex(json['tertiary']),
      onTertiary: _colorFromHex(json['onTertiary']),
      tertiaryContainer: _colorFromHex(json['tertiaryContainer']),
      onTertiaryContainer: _colorFromHex(json['onTertiaryContainer']),
      error: _colorFromHex(json['error']),
      onError: _colorFromHex(json['onError']),
      surface: _colorFromHex(json['surface']),
      onSurface: _colorFromHex(json['onSurface']),
      background: _colorFromHex(json['background']),
      onBackground: _colorFromHex(json['onBackground']),
      brightness: brightness,
    );
  }

  // Convert a Color to its Hex string representation
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  // Convert a Hex string to a Color object
  Color _colorFromHex(String hex) {
    return Color(int.parse(hex.replaceFirst('#', ''), radix: 16));
  }
}
