import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/navigation_constants.dart';
import '../themes/theme_provider.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    bool isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    TextTheme textTheme = themeProvider.themeData.textTheme;
    ColorScheme colorScheme = themeProvider.themeData.colorScheme;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: colorScheme.onPrimaryContainer,
        backgroundColor: themeProvider.themeData.colorScheme.primaryContainer,
        title: Text(
          NavigationConstants.optionsRoute,
          style: textTheme.bodyLarge?.copyWith(
            color: themeProvider.themeData.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      body: Container(
        color: themeProvider.themeData.colorScheme.secondaryContainer,
        child: ListView(
          children: [
            Container(
              color: themeProvider.themeData.colorScheme.primaryContainer,
              child: ListTile(
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
            ),
            Divider(
              height: 1,
              color: themeProvider.themeData.colorScheme.onPrimaryContainer,
            ),
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
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isDarkMode
                          ? theme.darkTheme.colorScheme.primary
                          : theme.lightTheme.colorScheme.primary,
                    ),
                    title: Text(
                      theme.name,
                      style: textTheme.bodySmall?.copyWith(
                        color: themeProvider.themeData.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    onTap: () => themeProvider.switchTheme(theme.name),
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