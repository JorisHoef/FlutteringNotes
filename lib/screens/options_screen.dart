import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/navigation_constants.dart';
import '../constants/notes_constants.dart';
import '../providers/theme_provider.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(optionsRoute),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(toggleThemeText),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
