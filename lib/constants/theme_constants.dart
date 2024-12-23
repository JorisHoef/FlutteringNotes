import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF6200EE);
const Color secondaryColor = Color(0xFF03DAC6);
const Color tertiaryColor = Color(0xFF018786);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    primary: primaryColor,
    primaryContainer: Color(0xFFBB86FC),
    secondary: secondaryColor,
    secondaryContainer: Color(0xFF03DAC6),
    surface: Colors.white,
    background: Colors.white,
    error: Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
    tertiary: tertiaryColor,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    primary: primaryColor,
    primaryContainer: Color(0xFFBB86FC),
    secondary: secondaryColor,
    secondaryContainer: Color(0xFF03DAC6),
    surface: Color(0xFF121212),
    background: Color(0xFF121212),
    error: Color(0xFFCF6679),
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.black,
    brightness: Brightness.dark,
    tertiary: tertiaryColor,
  ),
);
