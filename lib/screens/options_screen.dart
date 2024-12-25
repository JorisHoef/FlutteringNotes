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
                            // Apply the customized theme to the ThemeProvider instantly
                            themeProvider.customizeTheme(
                              themeName: themeName,
                              lightScheme: ColorScheme(
                                primary: updatedColors['lightPrimaryContainer']!,
                                onPrimary: updatedColors['lightOnPrimaryContainer']!,
                                primaryContainer: updatedColors['lightPrimaryContainer']!,
                                onPrimaryContainer: updatedColors['lightOnPrimaryContainer']!,
                                secondary: updatedColors['lightSecondaryContainer']!,
                                onSecondary: updatedColors['lightOnSecondaryContainer']!,
                                secondaryContainer: updatedColors['lightSecondaryContainer']!,
                                onSecondaryContainer: updatedColors['lightOnSecondaryContainer']!,
                                tertiary: updatedColors['lightTertiaryContainer']!,
                                onTertiary: updatedColors['lightOnTertiaryContainer']!,
                                tertiaryContainer: updatedColors['lightTertiaryContainer']!,
                                onTertiaryContainer: updatedColors['lightOnTertiaryContainer']!,
                                brightness: Brightness.light,
                                error: theme.lightTheme.colorScheme.error,
                                onError: theme.lightTheme.colorScheme.onError,
                                surface: theme.lightTheme.colorScheme.surface,
                                onSurface: theme.lightTheme.colorScheme.onSurface,
                              ),
                              darkScheme: ColorScheme(
                                primary: updatedColors['darkPrimaryContainer']!,
                                onPrimary: updatedColors['darkOnPrimaryContainer']!,
                                primaryContainer: updatedColors['darkPrimaryContainer']!,
                                onPrimaryContainer: updatedColors['darkOnPrimaryContainer']!,
                                secondary: updatedColors['darkSecondaryContainer']!,
                                onSecondary: updatedColors['darkOnSecondaryContainer']!,
                                secondaryContainer: updatedColors['darkSecondaryContainer']!,
                                onSecondaryContainer: updatedColors['darkOnSecondaryContainer']!,
                                tertiary: updatedColors['darkTertiaryContainer']!,
                                onTertiary: updatedColors['darkOnTertiaryContainer']!,
                                tertiaryContainer: updatedColors['darkTertiaryContainer']!,
                                onTertiaryContainer: updatedColors['darkOnTertiaryContainer']!,
                                brightness: Brightness.dark,
                                error: theme.darkTheme.colorScheme.error,
                                onError: theme.darkTheme.colorScheme.onError,
                                surface: theme.darkTheme.colorScheme.surface,
                                onSurface: theme.darkTheme.colorScheme.onSurface,
                              ),
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

          // Navigate to the ThemeScreen in "Add Theme" mode
          final newTheme = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThemeScreen(
                initialTheme: ThemeModel(
                  name: '', // Blank name for newly created theme
                  lightTheme: ThemeData.from(
                    colorScheme: const ColorScheme.light(),
                  ),
                  darkTheme: ThemeData.from(
                    colorScheme: const ColorScheme.dark(),
                  ),
                ),
                initialIsDarkMode: false, // Default to light mode
                onThemeChange: (String themeName, Map<String, Color> updatedColors) {
                  // Update the ThemeProvider with the edited themes
                  themeProvider.customizeTheme(
                    themeName: themeName,
                    lightScheme: ColorScheme(
                      primary: updatedColors['lightPrimaryContainer']!,
                      onPrimary: updatedColors['lightOnPrimaryContainer']!,
                      primaryContainer: updatedColors['lightPrimaryContainer']!,
                      onPrimaryContainer: updatedColors['lightOnPrimaryContainer']!,
                      secondary: updatedColors['lightSecondaryContainer']!,
                      onSecondary: updatedColors['lightOnSecondaryContainer']!,
                      secondaryContainer: updatedColors['lightSecondaryContainer']!,
                      onSecondaryContainer: updatedColors['lightOnSecondaryContainer']!,
                      tertiary: updatedColors['lightTertiaryContainer']!,
                      onTertiary: updatedColors['lightOnTertiaryContainer']!,
                      tertiaryContainer: updatedColors['lightTertiaryContainer']!,
                      onTertiaryContainer: updatedColors['lightOnTertiaryContainer']!,
                      brightness: Brightness.light, // Default brightness
                      error: Colors.red, // Default error color
                      onError: Colors.white,
                      surface: Colors.grey,
                      onSurface: Colors.black,
                    ),
                    darkScheme: ColorScheme(
                      primary: updatedColors['darkPrimaryContainer']!,
                      onPrimary: updatedColors['darkOnPrimaryContainer']!,
                      primaryContainer: updatedColors['darkPrimaryContainer']!,
                      onPrimaryContainer: updatedColors['darkOnPrimaryContainer']!,
                      secondary: updatedColors['darkSecondaryContainer']!,
                      onSecondary: updatedColors['darkOnSecondaryContainer']!,
                      secondaryContainer: updatedColors['darkSecondaryContainer']!,
                      onSecondaryContainer: updatedColors['darkOnSecondaryContainer']!,
                      tertiary: updatedColors['darkTertiaryContainer']!,
                      onTertiary: updatedColors['darkOnTertiaryContainer']!,
                      tertiaryContainer: updatedColors['darkTertiaryContainer']!,
                      onTertiaryContainer: updatedColors['darkOnTertiaryContainer']!,
                      brightness: Brightness.dark, // Default brightness
                      error: Colors.red,
                      onError: Colors.black,
                      surface: Colors.black,
                      onSurface: Colors.white,
                    ),
                  );
                },
              ),
            ),
          );

          // Save the new theme (if any) to the ThemeProvider
          if (newTheme != null) {
            themeProvider.addTheme(newTheme); // Persisting here is automatic via the updated 'addTheme'
          }
        },
        tooltip: AppStrings.addThemeText, // Tooltip for "Add Theme"
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}