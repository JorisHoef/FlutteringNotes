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
      primaryContainer: Color(0xFFBBDEFB),
      secondaryContainer: Color(0xFFE3F2FD),
      tertiaryContainer: Colors.lightBlue,
      onPrimaryContainer: Color(0xFF0D47A1),
      onSecondaryContainer: Color(0xFF1976D2),
      onTertiaryContainer: Colors.pink,
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
      primaryContainer: Color(0xFF0D47A1),
      secondaryContainer: Color(0xFF1565C0),
      tertiaryContainer: Colors.lightBlueAccent,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.pink,
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
      primaryContainer: Color(0xFFBBDEFB),
      secondaryContainer: Color(0xFFE8EAF6),
      tertiaryContainer: Colors.deepPurpleAccent,
      onPrimaryContainer: Color(0xFF303F9F),
      onSecondaryContainer: Color(0xFF5C6BC0),
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyIndigo, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF303F9F),
      secondaryContainer: Color(0xFF3949AB),
      tertiaryContainer: Colors.purple,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.pink,
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
      primaryContainer: Color(0xFFC8E6C9),
      secondaryContainer: Color(0xFFB2DFDB),
      tertiaryContainer: Colors.lightGreen,
      onPrimaryContainer: Color(0xFF1B5E20),
      onSecondaryContainer: Color(0xFF2C6E49),
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyGreen, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF1B5E20),
      secondaryContainer: Color(0xFF2C6E49),
      tertiaryContainer: Colors.green,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.pink,
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
      primaryContainer: Color(0xFFFFCDD2),
      secondaryContainer: Color(0xFFF8BBD0),
      tertiaryContainer: Colors.deepOrange,
      onPrimaryContainer: Color(0xFFF44336),
      onSecondaryContainer: Color(0xFFEF9A9A),
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyRed, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF1B1C26),
      secondaryContainer: Color(0xFF2B2A2A),
      tertiaryContainer: Colors.red,
      onPrimaryContainer: Color(0xFFF44336),
      onSecondaryContainer: Color(0xFFEF9A9A),
      onTertiaryContainer: Colors.pink,
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
      primaryContainer: Color(0xFF80DEEA),
      secondaryContainer: Color(0xFFB2EBF2),
      tertiaryContainer: Color(0xFFE0F7FA),
      onPrimaryContainer: Color(0xFF1B1C26),
      onSecondaryContainer: Color(0xFF2B2A2A),
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF141218),
      secondaryContainer: Color(0xFF1B1C26),
      tertiaryContainer: Color(0xFF004D40),
      onPrimaryContainer: Color(0xFF82CBD9),
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.pink,
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
  ThemeModel(
    name: 'Electron-Inspired Theme, Brighter Primary',
    lightTheme: ThemeModel.buildLightTheme(
      primaryContainer: Color(0xFF80DEEA),
      secondaryContainer: Color(0xFFB2EBF2),
      tertiaryContainer: Color(0xFFE0F7FA),
      onPrimaryContainer: Color(0xFF1B1C26),
      onSecondaryContainer: Color(0xFF2B2A2A),
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF141218),
      secondaryContainer: Color(0xFF1B1C26),
      tertiaryContainer: Color(0xFF004D40),
      onPrimaryContainer: Color(0xFF9DE8F7),
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.pink,
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
  ThemeModel(
    name: 'Electron-Inspired Theme 2',
    lightTheme: ThemeModel.buildLightTheme(
      primaryContainer: Color(0xFF80DEEA),
      secondaryContainer: Color(0xFFB2EBF2),
      tertiaryContainer: Color(0xFFE0F7FA),
      onPrimaryContainer: Color(0xFF1B1C26),
      onSecondaryContainer: Color(0xFF2B2A2A),
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF1B1C26),
      secondaryContainer: Color(0xFF141218),
      tertiaryContainer: Color(0xFF004D40),
      onPrimaryContainer: Color(0xFF82CBD9),
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.pink,
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
  ThemeModel(
    name: 'Electron-Inspired Theme 3 (actual Electron)',
    lightTheme: ThemeModel.buildLightTheme(
      primaryContainer: Color(0xFF80DEEA),
      secondaryContainer: Color(0xFFB2EBF2),
      tertiaryContainer: Color(0xFFE0F7FA),
      onPrimaryContainer: Color(0xFF1B1C26),
      onSecondaryContainer: Color(0xFF2B2A2A),
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF1B1C26),
      secondaryContainer: Color(0xFF1B1B1D),
      tertiaryContainer: Color(0xFF004D40),
      onPrimaryContainer: Color(0xFF82CBD9),
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(
            fontFamily: ThemeConstants.fontFamilyElectron,
            fontSize: ThemeConstants.fontSizeSmall
        ),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
  ),  ThemeModel(
    name: 'Electron-Inspired Theme 3, Brighter Primary (actual Electron)',
    lightTheme: ThemeModel.buildLightTheme(
      primaryContainer: Color(0xFF80DEEA),
      secondaryContainer: Color(0xFFB2EBF2),
      tertiaryContainer: Color(0xFFE0F7FA),
      onPrimaryContainer: Color(0xFF1B1C26),
      onSecondaryContainer: Color(0xFF2B2A2A),
      onTertiaryContainer: Colors.pink,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF1B1C26),
      secondaryContainer: Color(0xFF1B1B1D),
      tertiaryContainer: Color(0xFF004D40),
      onPrimaryContainer: Color(0xFF9DE8F7),
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.pink,
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
  ThemeModel(
    name: 'Electron-Inspired Theme 4',
    lightTheme: ThemeModel.buildLightTheme(
      primaryContainer: Color(0xFF80DEEA),
      secondaryContainer: Color(0xFFB2EBF2),
      tertiaryContainer: Color(0xFFE0F7FA),
      onPrimaryContainer: Color(0xFF1B1C26),
      onSecondaryContainer: Color(0xFF2B2A2A),
      onTertiaryContainer: Color(0xFF141218),
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF1B1B1D),
      secondaryContainer: Color(0xFF1B1C26),
      tertiaryContainer: Color(0xFF141218),
      onPrimaryContainer: Color(0xFF82CBD9),
      onSecondaryContainer: Color(0xFFDFDFDF),
      onTertiaryContainer: Color(0xFF00BCD4),
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
  ThemeModel(
    name: 'Electron-Inspired Theme 4, Brighter Primary',
    lightTheme: ThemeModel.buildLightTheme(
      primaryContainer: Color(0xFF80DEEA),
      secondaryContainer: Color(0xFFB2EBF2),
      tertiaryContainer: Color(0xFFE0F7FA),
      onPrimaryContainer: Color(0xFF1B1C26),
      onSecondaryContainer: Color(0xFF2B2A2A),
      onTertiaryContainer: Color(0xFF00BCD4),
      textTheme: TextTheme(
        bodySmall: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeSmall),
        bodyMedium: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeMedium),
        bodyLarge: TextStyle(fontFamily: ThemeConstants.fontFamilyElectron, fontSize: ThemeConstants.fontSizeLarge),
      ),
    ),
    darkTheme: ThemeModel.buildDarkTheme(
      primaryContainer: Color(0xFF1B1B1D),
      secondaryContainer: Color(0xFF1B1C26),
      tertiaryContainer: Color(0xFF141218),
      onPrimaryContainer: Color(0xFF9DE8F7),
      onSecondaryContainer: Color(0xFFDFDFDF),
      onTertiaryContainer: Color(0xFF00BCD4),
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