import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            title: Text("Toggle Dark/Light Mode"),
            trailing: Switch(
              value: themeProvider.themeData.brightness == Brightness.dark,
              onChanged: (value) => themeProvider.toggleThemeMode(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Select Theme'),
          ),
          ...themeProvider.availableThemes.map((theme) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.lightTheme.colorScheme.primary,
              ),
              title: Text(theme.name),
              onTap: () => themeProvider.switchTheme(theme.name),
            );
          }).toList(),
        ],
      ),
    );
  }
}