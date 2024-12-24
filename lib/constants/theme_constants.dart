import 'package:flutter/material.dart';

import '../themes/theme_manager.dart';

class ThemeConstants {
  static const double fontSizeSmall = 14.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeLarge = 24.0;
  static const double fontSizeXLarge = 30.0;
}

List<ThemeModel> predefinedThemes() => [
  ThemeModel(
    name: 'Blue Theme',
    lightTheme: ThemeModel.buildLightTheme(
      primary: Color(0xFF2196F3),
      secondary: Color(0xFF90CAF9),
      tertiary: Colors.blueAccent,
      tertiaryContainer: Colors.lightBlue,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Color(0xFF2B2A2A),
      onSurface: Color(0xFF2B2A2A),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFF2196F3),
      secondary: Color(0xFF90CAF9),
      tertiary: Colors.blueAccent,
      tertiaryContainer: Colors.lightBlueAccent,
      surface: Color(0xFF1B1B1D),
      onPrimary: Color(0xFF1B1B1D),
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
  ),
  ThemeModel(
    name: 'Indigo Theme',
    lightTheme: ThemeModel.buildLightTheme(
      primary: Color(0xFF6200EE),
      secondary: Color(0xFFBB86FC),
      tertiary: Colors.purple,
      tertiaryContainer: Colors.deepPurpleAccent,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFF6200EE),
      secondary: Color(0xFFBB86FC),
      tertiary: Colors.purpleAccent,
      tertiaryContainer: Colors.purple,
      surface: Color(0xFF121212),
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
  ),
  ThemeModel(
    name: 'Green Theme',
    lightTheme: ThemeModel.buildLightTheme(
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFFA5D6A7),
      tertiary: Colors.greenAccent,
      tertiaryContainer: Colors.lightGreen,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Color(0xFF2B2A2A),
      onSurface: Color(0xFF2B2A2A),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFFA5D6A7),
      tertiary: Colors.greenAccent,
      tertiaryContainer: Colors.green,
      surface: Color(0xFF2B2A2A),
      onPrimary: Color(0xFF2B2A2A),
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
  ),
  ThemeModel(
    name: 'Red Theme',
    lightTheme: ThemeModel.buildLightTheme(
      primary: Color(0xFFF44336),
      secondary: Color(0xFFEF9A9A),
      tertiary: Colors.redAccent,
      tertiaryContainer: Colors.deepOrange,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Color(0xFF2B2A2A),
      onSurface: Color(0xFF2B2A2A),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFFF44336),
      secondary: Color(0xFFEF9A9A),
      tertiary: Colors.redAccent,
      tertiaryContainer: Colors.red,
      surface: Color(0xFF2B2A2A),
      onPrimary: Color(0xFF2B2A2A),
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
  ),
  ThemeModel(
    name: 'Electron-Inspired Theme',
    lightTheme: ThemeModel.buildLightTheme(
      primary: Color(0xFF1C9EB3),
      secondary: Color(0xFF82CBD9),
      tertiary: Color(0xFF00BCD4),
      tertiaryContainer: Color(0xFFE0F7FA),
      surface: Color(0xFFF4F4F4),
      onPrimary: Colors.white,
      onSecondary: Color(0xFF2B2A2A),
      onSurface: Color(0xFF2B2A2A),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFF1C9EB3),
      secondary: Color(0xFF82CBD9),
      tertiary: Color(0xFF00BCD4),
      tertiaryContainer: Color(0xFF004D40),
      surface: Color(0xFF1B1C26),
      onPrimary: Color(0xFF1B1C26),
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
  ),
];