import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../themes/theme_provider.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Options"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppStrings.toggleThemeText),
            trailing: Switch(
              value: themeProvider.themeData.brightness == Brightness.dark,
              onChanged: (value) => themeProvider.toggleThemeMode(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(AppStrings.selectedThemeText),
          ),
          ...themeProvider.availableThemes.map((theme) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.lightTheme.colorScheme.primary,
              ),
              title: Text(theme.name),
              onTap: () => themeProvider.switchTheme(theme.name),
            );
          }),
        ],
      ),
    );
  }
}