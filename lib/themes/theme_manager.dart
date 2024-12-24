import 'package:flutter/material.dart';

class ThemeValues {
  // Font sizes
  static const double fontSizeSmall = 14.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeLarge = 24.0;
  static const double fontSizeXLarge = 30.0;
}

class AppTheme {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  AppTheme({required this.lightTheme, required this.darkTheme});
}

class Themes {
  static AppTheme blueTheme = AppTheme(
    lightTheme: _buildLightTheme(
      primary: Color(0xFF2196F3),
      secondary: Color(0xFF90CAF9),
    ),
    darkTheme: _buildDarkTheme(
      primary: Color(0xFF2196F3),
      secondary: Color(0xFF90CAF9),
    ),
  );

  static AppTheme indigoTheme = AppTheme(
    lightTheme: _buildLightTheme(
      primary: Color(0xFF6200EE),
      secondary: Color(0xFFBB86FC),
    ),
    darkTheme: _buildDarkTheme(
      primary: Color(0xFF6200EE),
      secondary: Color(0xFFBB86FC),
    ),
  );

  static AppTheme greenTheme = AppTheme(
    lightTheme: _buildLightTheme(
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFFA5D6A7),
    ),
    darkTheme: _buildDarkTheme(
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFFA5D6A7),
    ),
  );

  static ThemeData _buildLightTheme({
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

  static ThemeData _buildDarkTheme({
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