import 'package:flutter/material.dart';
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
          // Button to toggle between light and dark themes
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: _toggleThemeMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Theme Color Pickers
            Padding(
              padding: const EdgeInsets.all(16.0),
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
            // Preview the theme
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16),
                color: isDarkMode
                    ? currentTheme.darkTheme.colorScheme.primaryContainer
                    : currentTheme.lightTheme.colorScheme.primaryContainer,
                child: Column(
                  children: [
                    Text(
                      'Theme Preview',
                      style: isDarkMode
                          ? currentTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: currentTheme.darkTheme.colorScheme.onPrimaryContainer,
                      )
                          : currentTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: currentTheme.lightTheme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Primary Text Color',
                        style: isDarkMode
                            ? currentTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: currentTheme.darkTheme.colorScheme.onPrimaryContainer,
                        )
                            : currentTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: currentTheme.lightTheme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Secondary Text Color',
                        style: isDarkMode
                            ? currentTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: currentTheme.darkTheme.colorScheme.onSecondaryContainer,
                        )
                            : currentTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: currentTheme.lightTheme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the color pickers
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
                  title: Text('Select $label'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Nested preview for Primary, Secondary, and Tertiary Containers
                        Container(
                          padding: EdgeInsets.all(8),
                          color: primaryContainer,
                          child: Column(
                            children: [
                              Text(
                                'Primary Container',
                                style: TextStyle(color: onPrimaryContainer),
                              ),
                              Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                color: secondaryContainer,
                                child: Column(
                                  children: [
                                    Text(
                                      'Secondary Container',
                                      style: TextStyle(color: onSecondaryContainer),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.all(8),
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
                        ),
                        SizedBox(height: 20),
                        // Color Picker
                        ColorPicker(
                          pickerColor: tempColor,
                          onColorChanged: (color) {
                            setState(() {
                              tempColor = color; // Update temporary color
                            });
                            onColorChanged(color); // Pass the color back
                          },
                          enableAlpha: true,
                         // showIndicator: true,
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
}