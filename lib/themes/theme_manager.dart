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
        primaryContainer: Color(int.parse(json['primaryContainerColor'])),
        secondaryContainer: Color(int.parse(json['secondaryContainerColor'])),
        onPrimaryContainer: Color(int.parse(json['onPrimaryContainerColor'])),
        onSecondaryContainer: Color(int.parse(json['onSecondaryContainerColor'])),
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
        primaryContainer: Color(int.parse(json['primaryContainerColor'])),
        secondaryContainer: Color(int.parse(json['secondaryContainerColor'])),
        onPrimaryContainer: Color(int.parse(json['onPrimaryContainerColor'])),
        onSecondaryContainer: Color(int.parse(json['onSecondaryContainerColor'])),
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
    required Color primaryContainer,
    required Color secondaryContainer,
    required Color onPrimaryContainer,
    required Color onSecondaryContainer,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: primary,
        primaryContainer: primaryContainer,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        surface: surface,
        error: Colors.red,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onPrimaryContainer: onPrimaryContainer,
        onSecondaryContainer: onSecondaryContainer,
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
    required Color primaryContainer,
    required Color secondaryContainer,
    required Color onPrimaryContainer,
    required Color onSecondaryContainer,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: primary,
        primaryContainer: primaryContainer,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        surface: surface,
        error: Colors.red,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onPrimaryContainer: onPrimaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
    );
  }
}