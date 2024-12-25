import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/navigation_constants.dart';
import '../models/theme_model.dart';
import '../providers/theme_provider.dart';
import '../widgets/listTile_withMenu.dart';
import 'theme_screen.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    bool isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    TextTheme textTheme = themeProvider.themeData.textTheme;
    ColorScheme colorScheme = themeProvider.themeData.colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          surfaceTintColor: colorScheme.primaryContainer,
          backgroundColor: themeProvider.themeData.colorScheme.primaryContainer,
          title: Text(
            NavigationConstants.optionsRoute,
            style: textTheme.bodyLarge?.copyWith(
              color: themeProvider.themeData.colorScheme.onPrimaryContainer,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: themeProvider.themeData.colorScheme.primaryContainer,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      AppStrings.toggleThemeText,
                      style: textTheme.bodySmall?.copyWith(
                        color: themeProvider.themeData.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    trailing: Switch(
                      activeColor: colorScheme.secondaryContainer,
                      activeTrackColor: colorScheme.onPrimaryContainer,
                      inactiveThumbColor: colorScheme.primaryContainer,
                      inactiveTrackColor: colorScheme.secondaryContainer,
                      value: isDarkMode,
                      onChanged: (value) => themeProvider.toggleThemeMode(),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: themeProvider.themeData.colorScheme.onPrimaryContainer,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: themeProvider.themeData.colorScheme.secondaryContainer,
        child: ListView(
          children: [
            Column(
              children: [
                ListTile(
                  title: Text(
                    AppStrings.selectThemeText,
                    style: textTheme.bodyMedium?.copyWith(
                      color: themeProvider.themeData.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
                ...themeProvider.availableThemes.map((theme) {
                  return ListTileWithMenu(
                    leadingWidget: CircleAvatar(
                      backgroundColor: isDarkMode
                          ? theme.darkTheme.colorScheme.primary
                          : theme.lightTheme.colorScheme.primary,
                    ),
                    title: theme.name,
                    onTap: () => themeProvider.switchTheme(theme.name),
                    titleStyle: textTheme.bodySmall,
                    onDelete: () => themeProvider.deleteTheme(theme.name),
                    onEdit: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThemeScreen(
                          initialTheme: theme,
                          initialIsDarkMode: isDarkMode,
                            onThemeChange: (themeName, updatedColors) {
                              themeProvider.customizeTheme(
                                themeName: themeName,
                                lightScheme: _generateColorScheme(
                                    updatedColors,
                                    Brightness.light,
                                    theme.lightTheme.colorScheme),
                                darkScheme: _generateColorScheme(
                                    updatedColors,
                                    Brightness.dark,
                                    theme.darkTheme.colorScheme),
                              );
                            },
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final themeProvider = context.read<ThemeProvider>();

          final newTheme = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThemeScreen(
                initialTheme: ThemeModel(
                  name: '',
                  lightTheme: ThemeData.from(
                    colorScheme: const ColorScheme.light(),
                  ),
                  darkTheme: ThemeData.from(
                    colorScheme: const ColorScheme.dark(),
                  ),
                ),
                initialIsDarkMode: false,
                onThemeChange: (themeName, updatedColors) {
                  themeProvider.customizeTheme(
                    themeName: themeName,
                    lightScheme: _generateColorScheme(
                        updatedColors,
                        Brightness.light,
                        const ColorScheme.light()),
                    darkScheme: _generateColorScheme(
                        updatedColors,
                        Brightness.dark,
                        const ColorScheme.dark()),
                  );
                },
              ),
            ),
          );

          if (newTheme != null) {
            themeProvider.addTheme(newTheme);
          }
        },
        tooltip: AppStrings.addThemeText,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  ColorScheme _generateColorScheme(Map<String, Color> updatedColors, Brightness brightness, ColorScheme fallbackScheme) {
    return ColorScheme(
      primary: updatedColors['${brightness == Brightness.light ? "light" : "dark"}PrimaryContainer'] ?? fallbackScheme.primary,
      onPrimary: updatedColors['${brightness == Brightness.light ? "light" : "dark"}OnPrimaryContainer'] ?? fallbackScheme.onPrimary,
      primaryContainer: updatedColors['${brightness == Brightness.light ? "light" : "dark"}PrimaryContainer'] ?? fallbackScheme.primaryContainer,
      onPrimaryContainer: updatedColors['${brightness == Brightness.light ? "light" : "dark"}OnPrimaryContainer'] ?? fallbackScheme.onPrimaryContainer,
      secondary: updatedColors['${brightness == Brightness.light ? "light" : "dark"}SecondaryContainer'] ?? fallbackScheme.secondary,
      onSecondary: updatedColors['${brightness == Brightness.light ? "light" : "dark"}OnSecondaryContainer'] ?? fallbackScheme.onSecondary,
      secondaryContainer: updatedColors['${brightness == Brightness.light ? "light" : "dark"}SecondaryContainer'] ?? fallbackScheme.secondaryContainer,
      onSecondaryContainer: updatedColors['${brightness == Brightness.light ? "light" : "dark"}OnSecondaryContainer'] ?? fallbackScheme.onSecondaryContainer,
      tertiary: updatedColors['${brightness == Brightness.light ? "light" : "dark"}TertiaryContainer'] ?? fallbackScheme.tertiary,
      onTertiary: updatedColors['${brightness == Brightness.light ? "light" : "dark"}OnTertiaryContainer'] ?? fallbackScheme.onTertiary,
      tertiaryContainer: updatedColors['${brightness == Brightness.light ? "light" : "dark"}TertiaryContainer'] ?? fallbackScheme.tertiaryContainer,
      onTertiaryContainer: updatedColors['${brightness == Brightness.light ? "light" : "dark"}OnTertiaryContainer'] ?? fallbackScheme.onTertiaryContainer,
      brightness: brightness,
      error: fallbackScheme.error, // Set fallback error
      onError: fallbackScheme.onError, // Set fallback onError
      surface: fallbackScheme.surface, // Set fallback surface
      onSurface: fallbackScheme.onSurface, // Set fallback onSurface
      background: fallbackScheme.background, // Set fallback background
      onBackground: fallbackScheme.onBackground, // Set fallback onBackground
    );
  }
}