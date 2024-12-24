import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/layout_constants.dart';
import '../constants/navigation_constants.dart';
import '../themes/theme_provider.dart';
import '../themes/theme_manager.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: defaultPadding,
          child: Text(NavigationConstants.optionsRoute),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(AppStrings.toggleThemeText),
              trailing: Switch(
                value: themeProvider.themeData.brightness == Brightness.dark,
                onChanged: (value) {
                  themeProvider.toggleThemeMode();
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Select Theme'),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Themes.blueTheme.lightTheme.colorScheme.primary,
              ),
              title: Text('Blue Theme'),
              onTap: () => themeProvider.switchTheme(Themes.blueTheme),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Themes.indigoTheme.lightTheme.colorScheme.primary,
              ),
              title: Text('Indigo Theme'),
              onTap: () => themeProvider.switchTheme(Themes.indigoTheme),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Themes.greenTheme.lightTheme.colorScheme.primary,
              ),
              title: Text('Green Theme'),
              onTap: () => themeProvider.switchTheme(Themes.greenTheme),
            ),
          ],
        ),
      ),
    );
  }
}