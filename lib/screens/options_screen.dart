import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/navigation_constants.dart';
import '../themes/theme_provider.dart';
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
                    onEdit: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThemeScreen(
                          initialTheme: theme,
                          onThemeChange: (themeName, updatedColors) => themeProvider.customizeTheme(
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
                              error: theme.lightTheme.colorScheme.error,
                              onError: theme.lightTheme.colorScheme.onError,
                              background: theme.lightTheme.colorScheme.background,
                              onBackground: theme.lightTheme.colorScheme.onBackground,
                              surface: theme.lightTheme.colorScheme.surface,
                              onSurface: theme.lightTheme.colorScheme.onSurface,
                              brightness: Brightness.light,
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
                              error: theme.darkTheme.colorScheme.error,
                              onError: theme.darkTheme.colorScheme.onError,
                              background: theme.darkTheme.colorScheme.background,
                              onBackground: theme.darkTheme.colorScheme.onBackground,
                              surface: theme.darkTheme.colorScheme.surface,
                              onSurface: theme.darkTheme.colorScheme.onSurface,
                              brightness: Brightness.dark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}