import 'package:flutter/material.dart';
import 'package:fluttering_notes/constants/layout_constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../themes/theme_manager.dart';
import '../themes/theme_provider.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late ThemeModel currentTheme;
  late Color onPrimaryContainer;
  late Color onSecondaryContainer;
  late Color onTertiaryContainer;
  late Color tertiaryContainer;
  late Color primaryContainer;
  late Color secondaryContainer;
  late TextTheme textTheme;
  bool isDarkMode = false; // Flag to toggle between light and dark themes

  @override
  void initState() {
    super.initState();

    textTheme = ThemeData.light().textTheme;
    onPrimaryContainer = Colors.blue;
    onSecondaryContainer = Colors.green;
    onTertiaryContainer = Colors.orange;
    tertiaryContainer = Colors.orangeAccent;
    primaryContainer = Colors.blueAccent;
    secondaryContainer = Colors.greenAccent;

    // Set the initial theme based on light or dark mode
    currentTheme = _buildTheme();
  }

  // Method to build light or dark theme
  ThemeModel _buildTheme() {
    return ThemeModel(
      name: 'Custom Theme',
      lightTheme: ThemeModel.buildLightTheme(
        onPrimaryContainer: onPrimaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        tertiaryContainer: tertiaryContainer,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        textTheme: textTheme,
      ),
      darkTheme: ThemeModel.buildDarkTheme(
        onPrimaryContainer: onPrimaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        tertiaryContainer: tertiaryContainer,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        textTheme: textTheme,
      ),
    );
  }

  // Update the theme based on the current dark/light mode
  void _updateTheme() {
    setState(() {
      currentTheme = _buildTheme();
    });
  }

  // Toggle between light and dark themes
  void _toggleThemeMode() {
    setState(() {
      isDarkMode = !isDarkMode;
      _updateTheme();
    });
  }

  Widget _buildNestedContainerPreview({
    required Color primaryContainer,
    required Color onPrimaryContainer,
    required Color secondaryContainer,
    required Color onSecondaryContainer,
    required Color tertiaryContainer,
    required Color onTertiaryContainer,
  }) {
    return Container(
      padding: defaultPadding,
      color: primaryContainer,
      child: Column(
        children: [
          Text(
            'Primary Container',
            style: TextStyle(color: onPrimaryContainer),
          ),
          Container(
            margin: defaultPadding,
            padding: defaultPadding,
            color: secondaryContainer,
            child: Column(
              children: [
                Text(
                  'Secondary Container',
                  style: TextStyle(color: onSecondaryContainer),
                ),
                Container(
                  margin: defaultPadding,
                  padding: defaultPadding,
                  color: tertiaryContainer,
                  child: Text(
                    'Tertiary Container',
                    style: TextStyle(color: onTertiaryContainer),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker(String label, Color initialColor, ValueChanged<Color> onColorChanged) {
    return ListTile(
      title: Text(label),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: initialColor,
          shape: BoxShape.circle,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Color tempColor = initialColor;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit $label'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNestedContainerPreview(
                          primaryContainer: primaryContainer,
                          onPrimaryContainer: onPrimaryContainer,
                          secondaryContainer: secondaryContainer,
                          onSecondaryContainer: onSecondaryContainer,
                          tertiaryContainer: tertiaryContainer,
                          onTertiaryContainer: onTertiaryContainer,
                        ),
                        SizedBox(height: 20),
                        ColorPicker(
                          pickerColor: tempColor,
                          onColorChanged: (color) {
                            setState(() {
                              tempColor = color;
                            });
                            onColorChanged(color);
                          },
                          enableAlpha: true,
                          pickerAreaHeightPercent: 0.5,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Select'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Preview'),
        backgroundColor: isDarkMode
            ? currentTheme.darkTheme.colorScheme.primaryContainer
            : currentTheme.lightTheme.colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: _toggleThemeMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: defaultPadding,
              child: Column(
                children: [
                  _buildColorPicker('Primary Container Color', primaryContainer, (color) {
                    setState(() {
                      primaryContainer = color;
                      _updateTheme();
                    });
                  }),
                  _buildColorPicker('On Primary Container Color', onPrimaryContainer, (color) {
                    setState(() {
                      onPrimaryContainer = color;
                      _updateTheme();
                    });
                  }),
                  _buildColorPicker('Secondary Container Color', secondaryContainer, (color) {
                    setState(() {
                      secondaryContainer = color;
                      _updateTheme();
                    });
                  }),
                  _buildColorPicker('On Secondary Container Color', onSecondaryContainer, (color) {
                    setState(() {
                      onSecondaryContainer = color;
                      _updateTheme();
                    });
                  }),
                  _buildColorPicker('Tertiary Container Color', tertiaryContainer, (color) {
                    setState(() {
                      tertiaryContainer = color;
                      _updateTheme();
                    });
                  }),
                  _buildColorPicker('On Tertiary Container Color', onTertiaryContainer, (color) {
                    setState(() {
                      onTertiaryContainer = color;
                      _updateTheme();
                    });
                  }),
                ],
              ),
            ),
            Divider(),
            // Main preview using the helper method
            Padding(
              padding: defaultPadding,
              child: _buildNestedContainerPreview(
                primaryContainer: isDarkMode
                    ? currentTheme.darkTheme.colorScheme.primaryContainer
                    : currentTheme.lightTheme.colorScheme.primaryContainer,
                onPrimaryContainer: isDarkMode
                    ? currentTheme.darkTheme.colorScheme.onPrimaryContainer
                    : currentTheme.lightTheme.colorScheme.onPrimaryContainer,
                secondaryContainer: isDarkMode
                    ? currentTheme.darkTheme.colorScheme.secondaryContainer
                    : currentTheme.lightTheme.colorScheme.secondaryContainer,
                onSecondaryContainer: isDarkMode
                    ? currentTheme.darkTheme.colorScheme.onSecondaryContainer
                    : currentTheme.lightTheme.colorScheme.onSecondaryContainer,
                tertiaryContainer: isDarkMode
                    ? currentTheme.darkTheme.colorScheme.tertiaryContainer
                    : currentTheme.lightTheme.colorScheme.tertiaryContainer,
                onTertiaryContainer: isDarkMode
                    ? currentTheme.darkTheme.colorScheme.onTertiaryContainer
                    : currentTheme.lightTheme.colorScheme.onTertiaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}