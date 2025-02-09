import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';

class ThemeModel {
  final String name;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  ThemeModel({
    required this.name,
    required this.lightTheme,
    required this.darkTheme,
  });

  ThemeModel copyWith({
    required String name,
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) {
    return ThemeModel(
      name: name,
      lightTheme: lightTheme ?? this.lightTheme,
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }

  static ThemeData buildLightTheme({
    required Color onPrimaryContainer,
    required Color onSecondaryContainer,
    required Color onTertiaryContainer,
    required Color tertiaryContainer,
    required Color primaryContainer,
    required Color secondaryContainer,
    required TextTheme textTheme,
  }) {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: onPrimaryContainer,
        secondary: onSecondaryContainer,
        tertiary: onTertiaryContainer,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        tertiaryContainer: tertiaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        onTertiaryContainer: onTertiaryContainer,
      ),
      textTheme: ThemeConstants.ensureFontFamily(textTheme),
    );
  }

  static ThemeData buildDarkTheme({
    required Color onPrimaryContainer,
    required Color onSecondaryContainer,
    required Color onTertiaryContainer,
    required Color tertiaryContainer,
    required Color primaryContainer,
    required Color secondaryContainer,
    required TextTheme textTheme,
  }) {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: onPrimaryContainer,
        secondary: onSecondaryContainer,
        tertiary: onTertiaryContainer,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        tertiaryContainer: tertiaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        onTertiaryContainer: onTertiaryContainer,
      ),
      textTheme: ThemeConstants.ensureFontFamily(textTheme),
    );
  }
}
