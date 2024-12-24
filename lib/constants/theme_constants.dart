import 'package:flutter/material.dart';

class ThemeValues{
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color tertiaryColor = Color(0xFF018786);

  static const double fontSizeSmall = 14.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeLarge = 24.0;
  static const double fontSizeXLarge = 30.0;
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    primary: ThemeValues.primaryColor,
    primaryContainer: Color(0xFFBB86FC),
    secondary: ThemeValues.secondaryColor,
    secondaryContainer: Color(0xFF03DAC6),
    surface: Colors.white,
    error: Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
    tertiary: ThemeValues.tertiaryColor,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    primary: ThemeValues.primaryColor,
    primaryContainer: Color(0xFFBB86FC),
    secondary: ThemeValues.secondaryColor,
    secondaryContainer: Color(0xFF03DAC6),
    surface: Color(0xFF121212),
    error: Color(0xFFCF6679),
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.black,
    brightness: Brightness.dark,
    tertiary: ThemeValues.tertiaryColor,
  ),
);