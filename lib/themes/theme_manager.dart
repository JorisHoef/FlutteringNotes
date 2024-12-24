import 'package:flutter/material.dart';

class ThemeModel {
  final String name;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  ThemeModel({
    required this.name,
    required this.lightTheme,
    required this.darkTheme,
  });

  // Allow uploading a JSON for colors, perhaps in future can use colorpicker
  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      name: json['name'],
      lightTheme: buildLightTheme(
        primary: Color(int.parse(json['primaryColor'])),
        secondary: Color(int.parse(json['secondaryColor'])),
      ),
      darkTheme: buildDarkTheme(
        primary: Color(int.parse(json['primaryColor'])),
        secondary: Color(int.parse(json['secondaryColor'])),
      ),
    );
  }

  static ThemeData buildLightTheme({
    required Color primary,
    required Color secondary,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: primary,
        primaryContainer: primary.withOpacity(0.7),
        secondary: secondary,
        secondaryContainer: secondary.withOpacity(0.7),
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
        tertiary: Colors.teal,
      ),
    );
  }

  static ThemeData buildDarkTheme({
    required Color primary,
    required Color secondary,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: primary,
        primaryContainer: primary.withOpacity(0.5),
        secondary: secondary,
        secondaryContainer: secondary.withOpacity(0.5),
        surface: Color(0xFF121212),
        error: Colors.red,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.black,
        brightness: Brightness.dark,
        tertiary: Colors.teal,
      ),
    );
  }
}