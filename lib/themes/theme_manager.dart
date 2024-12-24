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
    required TextTheme textTheme,
  }) {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        surface: surface,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        onSecondaryContainer: onSecondaryContainer,
      ),
      textTheme: textTheme,
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
    required TextTheme textTheme,
  }) {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        surface: surface,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        onSecondaryContainer: onSecondaryContainer,
      ),
      textTheme: textTheme,
    );
  }
}