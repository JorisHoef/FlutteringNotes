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

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      name: json['name'],
      lightTheme: buildLightTheme(
        primary: Color(int.parse(json['primaryColor'])),
        secondary: Color(int.parse(json['secondaryColor'])),
        tertiary: Color(int.parse(json['tertiaryColor'])),
        tertiaryContainer: Color(int.parse(json['tertiaryContainerColor'])),
        surface: Color(int.parse(json['surfaceColor'])),
        onPrimary: Color(int.parse(json['onPrimaryColor'])),
        onSecondary: Color(int.parse(json['onSecondaryColor'])),
        onSurface: Color(int.parse(json['onSurfaceColor'])),
      ),
      darkTheme: buildDarkTheme(
        primary: Color(int.parse(json['primaryColor'])),
        secondary: Color(int.parse(json['secondaryColor'])),
        tertiary: Color(int.parse(json['tertiaryColor'])),
        tertiaryContainer: Color(int.parse(json['tertiaryContainerColor'])),
        surface: Color(int.parse(json['surfaceColor'])),
        onPrimary: Color(int.parse(json['onPrimaryColor'])),
        onSecondary: Color(int.parse(json['onSecondaryColor'])),
        onSurface: Color(int.parse(json['onSurfaceColor'])),
      ),
    );
  }

  static ThemeData buildLightTheme({
    required Color primary,
    required Color secondary,
    required Color tertiary,
    required Color tertiaryContainer,
    required Color surface,
    required Color onPrimary,
    required Color onSecondary,
    required Color onSurface,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: primary,
        primaryContainer: primary.withOpacity(0.7),
        secondary: secondary,
        secondaryContainer: secondary.withOpacity(0.7),
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        surface: surface,
        error: Colors.red,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData buildDarkTheme({
    required Color primary,
    required Color secondary,
    required Color tertiary,
    required Color tertiaryContainer,
    required Color surface,
    required Color onPrimary,
    required Color onSecondary,
    required Color onSurface,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: primary,
        primaryContainer: primary.withOpacity(0.5),
        secondary: secondary,
        secondaryContainer: secondary.withOpacity(0.5),
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        surface: surface,
        error: Colors.red,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
    );
  }
}