import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttering_notes/storage/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/theme_model.dart';

class LocalThemeRepository extends ThemeRepository{
  final String _themesKey = "customThemes";
  final String _selectedThemeKey = "selectedTheme";

  // Fetch all themes with error handling
  @override
  Future<List<ThemeModel>> fetchThemes() async {
    final prefs = await SharedPreferences.getInstance();
    final themesJson = prefs.getStringList(_themesKey);

    if (themesJson == null) {
      // No stored themes, return an empty list
      return [];
    }

    final List<ThemeModel> themes = [];
    for (final themeJson in themesJson) {
      try {
        // Attempt to decode each theme JSON
        final Map<String, dynamic> decoded = json.decode(themeJson);
        themes.add(
          ThemeModel(
            name: decoded['name'],
            lightTheme: _buildThemeFromJson(decoded['lightTheme']),
            darkTheme: _buildThemeFromJson(decoded['darkTheme']),
          ),
        );
      } catch (e) {
        // Log or handle malformed JSON gracefully
        print('Error decoding theme JSON: $themeJson - $e');
      }
    }

    return themes;
  }

  // Add or update a theme
  @override
  Future<void> saveTheme(ThemeModel theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themes = await fetchThemes();

      // Replace existing or add new theme
      final updatedThemes = [
        for (final storedTheme in themes)
          if (storedTheme.name == theme.name) theme else storedTheme,
        if (!themes.any((storedTheme) => storedTheme.name == theme.name)) theme,
      ];

      // Save updated themes list
      final themesJson = updatedThemes.map((theme) {
        final lightJson = theme.lightTheme.toString(); // Simplify as an example
        final darkJson = theme.darkTheme.toString();
        return json.encode({
          'name': theme.name,
          'lightTheme': lightJson,
          'darkTheme': darkJson,
        });
      }).toList();

      await prefs.setStringList(_themesKey, themesJson);

      // Debugging: Log success
      print('[DEBUG] Themes successfully saved: $themesJson');
    } catch (e, stacktrace) {
      // Error logging
      print('[ERROR] Failed to save theme: ${theme.name}');
      print('[ERROR] Exception: $e');
      print('[ERROR] Stacktrace: $stacktrace');
    }
  }

  // Delete a theme
  @override
  Future<void> deleteTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    final themes = await fetchThemes();

    // Remove the theme by name
    final updatedThemes = themes.where((t) => t.name != themeName).toList();
    final themesJson =
    updatedThemes.map((theme) => json.encode(theme)).toList();

    prefs.setStringList(_themesKey, themesJson);
  }

  @override
  Future<void> saveDarkMode(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', isDarkMode);
      print('[DEBUG] Dark Mode state saved: $isDarkMode');
    } catch (e, stacktrace) {
      print('[ERROR] Failed to save Dark Mode state');
      print('[ERROR] Exception: $e');
      print('[ERROR] Stacktrace: $stacktrace');
    }
  }

  @override
  Future<bool?> fetchDarkMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool('isDarkMode');
      print('[DEBUG] Dark Mode state fetched: $isDarkMode');
      return isDarkMode; // Returns `true`, `false`, or `null` if not set
    } catch (e, stacktrace) {
      print('[ERROR] Failed to fetch Dark Mode state');
      print('[ERROR] Exception: $e');
      print('[ERROR] Stacktrace: $stacktrace');
      return null; // Return `null` in case of an error
    }
  }

  // Save selected theme name
  @override
  Future<void> saveSelectedTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_selectedThemeKey, themeName);
  }

  // Fetch selected theme name
  @override
  Future<String?> fetchSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedThemeKey);
  }

  // Build a ThemeData object from a JSON representation
  ThemeData _buildThemeFromJson(Map<String, dynamic> json) {
    // Convert JSON to ThemeData based on what was stored (color properties, etc.)
    // Note: In practice, you'll need to convert colors and text themes back
    return ThemeData();
  }
}