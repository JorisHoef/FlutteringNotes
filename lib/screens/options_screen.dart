import 'package:flutter/material.dart';
import 'package:fluttering_notes/constants/theme_constants.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/navigation_constants.dart';
import '../themes/theme_provider.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    bool isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.themeData.colorScheme.primaryContainer,
        title: Text(
          NavigationConstants.optionsRoute,
          style: TextStyle(
            color: themeProvider.themeData.colorScheme.onPrimaryContainer,
            fontSize: ThemeConstants.fontSizeLarge,
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
                style: TextStyle(
                  color: themeProvider.themeData.colorScheme.onPrimaryContainer,
                  fontSize: ThemeConstants.fontSizeSmall,
                ),
              ),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) => themeProvider.toggleThemeMode(),
              ),
            ),
            ),
            Divider(
              height: 1,
            ),
            Column(
              children: [
                ListTile(
                  title: Text(
                    AppStrings.selectThemeText,
                    style: TextStyle(
                      color: themeProvider.themeData.colorScheme.onSecondaryContainer,
                      fontSize: ThemeConstants.fontSizeMedium,
                    ),
                  ),
                ),
                ...themeProvider.availableThemes.map((theme) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isDarkMode
                          ? theme.darkTheme.colorScheme.secondary
                          : theme.lightTheme.colorScheme.secondary,
                    ),
                    title: Text(
                      theme.name,
                      style: TextStyle(
                        color: themeProvider.themeData.colorScheme.onSecondaryContainer,
                        fontSize: ThemeConstants.fontSizeSmall,
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