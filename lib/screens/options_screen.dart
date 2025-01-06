import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_strings.dart';
import '../constants/navigation_constants.dart';
import '../models/theme_model.dart';
import '../providers/theme_provider.dart';
import '../widgets/listTile_withMenu.dart';
import 'theme_screen.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the theme provider
    var themeProvider = context.watch<ThemeProvider>();

    // Dark mode toggle
    bool isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    // Theme styles
    TextTheme textTheme = themeProvider.themeData.textTheme;
    ColorScheme colorScheme = themeProvider.themeData.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver AppBar
          SliverAppBar(
            pinned: true,
            expandedHeight: 100.0,
            backgroundColor:
                themeProvider.themeData.colorScheme.primaryContainer,
            surfaceTintColor: colorScheme.primaryContainer,
            title: Text(
              NavigationConstants.optionsRoute,
              style: textTheme.bodyLarge?.copyWith(
                color: themeProvider.themeData.colorScheme.onPrimaryContainer,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete, // Delete icon
                  color: themeProvider.themeData.colorScheme.onPrimaryContainer,
                ),
                tooltip: AppStrings.deletePreferencesText, // Tooltip
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
              ),
            ],
            // Customize bottom section (toggle switch and divider)
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Container(
                // Background for the bottom area of the AppBar
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
                        activeTrackColor: colorScheme.primary,
                        inactiveThumbColor: colorScheme.primaryContainer,
                        inactiveTrackColor: colorScheme.onPrimaryContainer,
                        value: isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleThemeMode();
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: themeProvider
                          .themeData.colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Section Title (wrapped with SliverToBoxAdapter)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                AppStrings.selectThemeText,
                style: textTheme.bodyMedium?.copyWith(
                  color:
                      themeProvider.themeData.colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),

          // Theme List (SliverList)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final theme = themeProvider.availableThemes[index];

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
                            lightScheme: _generateColorScheme(updatedColors,
                                Brightness.light, theme.lightTheme.colorScheme),
                            darkScheme: _generateColorScheme(updatedColors,
                                Brightness.dark, theme.darkTheme.colorScheme),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              childCount: themeProvider.availableThemes.length,
            ),
          ),

          // Extra bottom padding (optional for floating action button spacing)
          SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
                  themeProvider.customizeTheme(
                    themeName: themeName,
                    lightScheme: _generateColorScheme(
                      updatedColors,
                      Brightness.light,
                      themeProvider.currentTheme.lightTheme.colorScheme,
                    ),
                    darkScheme: _generateColorScheme(
                      updatedColors,
                      Brightness.dark,
                      themeProvider.currentTheme.darkTheme.colorScheme,
                    ),
                  );
                },
              ),
            ),
          );

          if (newTheme != null) {
            debugPrint("New theme added: ${newTheme.name}");
            context.read<ThemeProvider>().addTheme(newTheme);
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
                '${brightness == Brightness.light ? "light" : "dark"}Primary'] ??
            fallbackScheme.primary,
        onPrimary: updatedColors[
                '${brightness == Brightness.light ? "light" : "dark"}OnPrimary'] ??
            fallbackScheme.onPrimary,
        primaryContainer: updatedColors[
                '${brightness == Brightness.light ? "light" : "dark"}PrimaryContainer'] ??
            fallbackScheme.primaryContainer,
        onPrimaryContainer: updatedColors[
                '${brightness == Brightness.light ? "light" : "dark"}OnPrimaryContainer'] ??
            fallbackScheme.onPrimaryContainer,
        brightness: brightness,
        error: fallbackScheme.error,
        onError: fallbackScheme.onError,
        surface: fallbackScheme.surface,
        onSurface: fallbackScheme.onSurface,
        secondary: fallbackScheme.secondary,
        onSecondary: fallbackScheme.onSecondary);
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await clearAllSharedPreferences();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppStrings.preferencesDeletedSuccess)),
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
    debugPrint('All shared preferences cleared!');
  }
}
