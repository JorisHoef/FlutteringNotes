import 'package:flutter/material.dart';

import '../themes/theme_manager.dart';

class ThemeConstants {
  static const double fontSizeSmall = 14.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeLarge = 24.0;
  static const double fontSizeXLarge = 30.0;

  static const String fontFamilyBlue = 'Roboto';
  static const String fontFamilyIndigo = 'Poppins';
  static const String fontFamilyGreen = 'Lato';
  static const String fontFamilyRed = 'SourceSerif4';
  static const String fontFamilyElectron = 'Montserrat';
  static const String fontFamilySerif = 'SourceSans3'; //unused for now
}

List<ThemeModel> predefinedThemes() => [
  ThemeModel(
    name: 'Blue Theme',
    lightTheme: ThemeModel.buildLightTheme(
      primary: Color(0xFF1E88E5),
      secondary: Color(0xFF42A5F5),
      tertiary: Colors.blueAccent,
      tertiaryContainer: Colors.lightBlue,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      primaryContainer: Color(0xFFBBDEFB),
      secondaryContainer: Color(0xFFE3F2FD),
      onPrimaryContainer: Color(0xFF0D47A1),
      onSecondaryContainer: Color(0xFF1976D2),
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontFamily: ThemeConstants.fontFamilyBlue,
          fontSize: ThemeConstants.fontSizeSmall,
        ),
        bodyMedium: TextStyle(
            fontFamily: ThemeConstants.fontFamilyBlue,
            fontSize: ThemeConstants.fontSizeMedium
        ),
        bodyLarge: TextStyle(
            fontFamily: ThemeConstants.fontFamilyBlue,
            fontSize: ThemeConstants.fontSizeLarge
        ),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFF1E88E5),
      secondary: Color(0xFF42A5F5),
      tertiary: Colors.blueAccent,
      tertiaryContainer: Colors.lightBlueAccent,
      surface: Color(0xFF1B1B1D),
      onPrimary: Color(0xFF1B1B1D),
      onSecondary: Colors.white,
      onSurface: Colors.white,
      primaryContainer: Color(0xFF0D47A1),
      secondaryContainer: Color(0xFF1565C0),
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyBlue, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyBlue, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyBlue, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
  ),
  ThemeModel(
    name: 'Indigo Theme',
    lightTheme: ThemeModel.buildLightTheme(
      primary: Color(0xFF3F51B5),
      secondary: Color(0xFF9FA8DA),
      tertiary: Colors.purple,
      tertiaryContainer: Colors.deepPurpleAccent,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      primaryContainer: Color(0xFFBBDEFB),
      secondaryContainer: Color(0xFFE8EAF6),
      onPrimaryContainer: Color(0xFF303F9F),
      onSecondaryContainer: Color(0xFF5C6BC0),
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFF3F51B5),
      secondary: Color(0xFF9FA8DA),
      tertiary: Colors.purpleAccent,
      tertiaryContainer: Colors.purple,
      surface: Color(0xFF121212),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      primaryContainer: Color(0xFF303F9F),
      secondaryContainer: Color(0xFF3949AB),
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
  ),
  ThemeModel(
    name: 'Green Theme',
    lightTheme: ThemeModel.buildLightTheme(
      primary: Color(0xFF388E3C),
      secondary: Color(0xFF81C784),
      tertiary: Colors.greenAccent,
      tertiaryContainer: Colors.lightGreen,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      primaryContainer: Color(0xFFC8E6C9),
      secondaryContainer: Color(0xFFB2DFDB),
      onPrimaryContainer: Color(0xFF1B5E20),
      onSecondaryContainer: Color(0xFF2C6E49),
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFF388E3C),
      secondary: Color(0xFF81C784),
      tertiary: Colors.greenAccent,
      tertiaryContainer: Colors.green,
      surface: Color(0xFF2B2A2A),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      primaryContainer: Color(0xFF1B5E20),
      secondaryContainer: Color(0xFF2C6E49),
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeLarge),
      ),
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
      primaryContainer: Color(0xFFFFCDD2),
      secondaryContainer: Color(0xFFF8BBD0),
      onPrimaryContainer: Color(0xFFF44336),
      onSecondaryContainer: Color(0xFFEF9A9A),
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFFF44336),
      secondary: Color(0xFFEF9A9A),
      tertiary: Colors.redAccent,
      tertiaryContainer: Colors.red,
      surface: Color(0xFF1B1C26),
      onPrimary: Color(0xFF1B1C26),
      onSecondary: Colors.white,
      onSurface: Color(0xFFF44336),
      primaryContainer: Color(0xFF1B1C26),
      secondaryContainer: Color(0xFF2B2A2A),
      onPrimaryContainer: Color(0xFFF44336),
      onSecondaryContainer: Color(0xFFEF9A9A),
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeLarge),
      ),
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
      primaryContainer: Color(0xFF80DEEA),
      secondaryContainer: Color(0xFFB2EBF2),
      onPrimaryContainer: Color(0xFF1B1C26),
      onSecondaryContainer: Color(0xFF2B2A2A),
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primary: Color(0xFF1C9EB3),
      secondary: Color(0xFF82CBD9),
      tertiary: Color(0xFF00BCD4),
      tertiaryContainer: Color(0xFF004D40),
      surface: Color(0xFF1B1C26),
      onPrimary: Color(0xFF1B1C26),
      onSecondary: Colors.white,
      onSurface: Color(0xFF82CBD9),
      primaryContainer: Color(0xFF141218),
      secondaryContainer: Color(0xFF1B1C26),
      onPrimaryContainer: Color(0xFF82CBD9),
      onSecondaryContainer: Colors.white,
      textTheme: TextTheme(
        bodySmall: TextStyle(
            fontFamily: ThemeConstants.fontFamilyElectron,
            fontSize: ThemeConstants.fontSizeSmall
        ),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
  ),
];