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

    return Scaffold(
      appBar: AppBar(
        title: Text(NavigationConstants.optionsRoute),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppStrings.toggleThemeText),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) => themeProvider.toggleThemeMode(),
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              color: themeProvider.themeData.colorScheme.secondaryContainer,
              child: Column(
                children: [
                  ListTile(
                    title: Text(AppStrings.selectThemeText),
                  ),
                  ...themeProvider.availableThemes.map((theme) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isDarkMode
                            ? theme.darkTheme.colorScheme.secondary
                            : theme.lightTheme.colorScheme.secondary,
                      ),
                      title: Text(theme.name),
                      onTap: () => themeProvider.switchTheme(theme.name),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}