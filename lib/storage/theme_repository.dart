import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/theme_model.dart';

class ThemeRepository {
  final String _themesKey = "customThemes";
  final String _selectedThemeKey = "selectedTheme";

  // Fetch all themes
  Future<List<ThemeModel>> fetchThemes() async {
    final prefs = await SharedPreferences.getInstance();
    final themesJson = prefs.getStringList(_themesKey);

    if (themesJson == null) return [];

    // Decode JSON and convert to ThemeModel objects
    return themesJson.map((theme) {
      final Map<String, dynamic> decoded = json.decode(theme);
      return ThemeModel(
        name: decoded['name'],
        lightTheme: _buildThemeFromJson(decoded['lightTheme']),
        darkTheme: _buildThemeFromJson(decoded['darkTheme']),
      );
    }).toList();
  }

  // Add or update a theme
  Future<void> saveTheme(ThemeModel theme) async {
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

    prefs.setStringList(_themesKey, themesJson);
  }

  // Delete a theme
  Future<void> deleteTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    final themes = await fetchThemes();

    // Remove the theme by name
    final updatedThemes = themes.where((t) => t.name != themeName).toList();
    final themesJson =
    updatedThemes.map((theme) => json.encode(theme)).toList();

    prefs.setStringList(_themesKey, themesJson);
  }

  // Save selected theme name
  Future<void> saveSelectedTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_selectedThemeKey, themeName);
  }

  // Fetch selected theme name
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