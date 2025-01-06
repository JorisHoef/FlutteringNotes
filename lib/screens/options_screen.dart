import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_keys.dart';
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
          actions: [
            // Add the action section in the AppBar
            IconButton(
              icon: Icon(
                Icons.delete, // Icon representing delete action
                color: themeProvider.themeData.colorScheme.onPrimaryContainer,
              ),
              tooltip:
                  AppStrings.deletePreferencesText, // Tooltip for the button
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
            ),
          ],
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
                        color: themeProvider
                            .themeData.colorScheme.onPrimaryContainer,
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
                    color:
                        themeProvider.themeData.colorScheme.onPrimaryContainer,
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
                      color: themeProvider
                          .themeData.colorScheme.onSecondaryContainer,
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
                              darkScheme: _generateColorScheme(updatedColors,
                                  Brightness.dark, theme.darkTheme.colorScheme),
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

          final newTheme = await Navigator.push<ThemeModel>(
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
                  final themeProvider = context.read<ThemeProvider>();
                  debugPrint("Updating existing theme: $themeName");

                  // Find the existing theme to customize
                  final existingTheme =
                      themeProvider.availableThemes.firstWhere(
                    (theme) => theme.name == themeName,
                    orElse: () => throw Exception('Theme not found!'),
                  );

                  // Customize the theme with updated lightScheme and darkScheme
                  themeProvider.customizeTheme(
                    themeName: themeName,
                    lightScheme: _generateColorScheme(
                      updatedColors,
                      Brightness.light,
                      existingTheme.lightTheme.colorScheme,
                    ),
                    darkScheme: _generateColorScheme(
                      updatedColors,
                      Brightness.dark,
                      existingTheme.darkTheme.colorScheme,
                    ),
                  );

                  // Save the updated theme in persistent storage as well
                  themeProvider.addTheme(
                    existingTheme.copyWith(
                      lightTheme: ThemeModel.buildLightTheme(
                        onPrimaryContainer:
                            updatedColors[AppKeys.lightOnPrimaryContainer]!,
                        onSecondaryContainer:
                            updatedColors[AppKeys.lightOnSecondaryContainer]!,
                        onTertiaryContainer:
                            updatedColors[AppKeys.lightOnTertiaryContainer]!,
                        primaryContainer:
                            updatedColors[AppKeys.lightPrimaryContainer]!,
                        secondaryContainer:
                            updatedColors[AppKeys.lightSecondaryContainer]!,
                        tertiaryContainer:
                            updatedColors[AppKeys.lightTertiaryContainer]!,
                        textTheme: existingTheme
                            .lightTheme.textTheme, // Keep existing textTheme
                      ),
                      darkTheme: ThemeModel.buildDarkTheme(
                        onPrimaryContainer:
                            updatedColors[AppKeys.darkOnPrimaryContainer]!,
                        onSecondaryContainer:
                            updatedColors[AppKeys.darkOnSecondaryContainer]!,
                        onTertiaryContainer:
                            updatedColors[AppKeys.darkOnTertiaryContainer]!,
                        primaryContainer:
                            updatedColors[AppKeys.darkPrimaryContainer]!,
                        secondaryContainer:
                            updatedColors[AppKeys.darkSecondaryContainer]!,
                        tertiaryContainer:
                            updatedColors[AppKeys.darkTertiaryContainer]!,
                        textTheme: existingTheme
                            .darkTheme.textTheme, // Keep existing textTheme
                      ),
                      name: '',
                    ),
                  );
                },
              ),
            ),
          );

          if (newTheme != null) {
            debugPrint("New theme created: ${newTheme.name}");
            await themeProvider.addTheme(newTheme); // Add theme to the provider
          } else {
            debugPrint("Theme creation was cancelled.");
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

  ColorScheme _generateColorScheme(Map<String, Color> updatedColors,
      Brightness brightness, ColorScheme fallbackScheme) {
    return ColorScheme(
      primary: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}PrimaryContainer'] ??
          fallbackScheme.primary,
      onPrimary: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}OnPrimaryContainer'] ??
          fallbackScheme.onPrimary,
      primaryContainer: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}PrimaryContainer'] ??
          fallbackScheme.primaryContainer,
      onPrimaryContainer: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}OnPrimaryContainer'] ??
          fallbackScheme.onPrimaryContainer,
      secondary: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}SecondaryContainer'] ??
          fallbackScheme.secondary,
      onSecondary: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}OnSecondaryContainer'] ??
          fallbackScheme.onSecondary,
      secondaryContainer: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}SecondaryContainer'] ??
          fallbackScheme.secondaryContainer,
      onSecondaryContainer: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}OnSecondaryContainer'] ??
          fallbackScheme.onSecondaryContainer,
      tertiary: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}TertiaryContainer'] ??
          fallbackScheme.tertiary,
      onTertiary: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}OnTertiaryContainer'] ??
          fallbackScheme.onTertiary,
      tertiaryContainer: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}TertiaryContainer'] ??
          fallbackScheme.tertiaryContainer,
      onTertiaryContainer: updatedColors[
              '${brightness == Brightness.light ? "light" : "dark"}OnTertiaryContainer'] ??
          fallbackScheme.onTertiaryContainer,
      brightness: brightness,
      error: fallbackScheme.error, // Set fallback error
      onError: fallbackScheme.onError, // Set fallback onError
      surface: fallbackScheme.surface, // Set fallback surface
      onSurface: fallbackScheme.onSurface, // Set fallback onBackground
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.deletePreferencesTitle),
          content: Text(AppStrings.deletePreferencesConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await clearAllSharedPreferences(); // Clear preferences
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppStrings.preferencesDeletedSuccess),
                  ),
                );
              },
              child: Text(
                AppStrings.confirm,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> clearAllSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('All shared preferences cleared!');
  }
}
