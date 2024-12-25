import 'package:flutter/material.dart';
import 'package:fluttering_notes/constants/layout_constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../themes/theme_manager.dart';

class ThemeScreen extends StatefulWidget {
  final ThemeModel initialTheme;
  final Function(String themeName, Map<String, Color>) onThemeChange;

  ThemeScreen({
    required this.initialTheme,
    required this.onThemeChange,
  });

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late ThemeModel _theme;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _theme = widget.initialTheme;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = isDarkMode ? _theme.darkTheme : _theme.lightTheme;
    final colorScheme = themeData.colorScheme;

    final primaryContainer = colorScheme.primaryContainer;
    final onPrimaryContainer = colorScheme.onPrimaryContainer;
    final secondaryContainer = colorScheme.secondaryContainer;
    final onSecondaryContainer = colorScheme.onSecondaryContainer;
    final tertiaryContainer = colorScheme.tertiaryContainer;
    final onTertiaryContainer = colorScheme.onTertiaryContainer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Preview'),
        backgroundColor: primaryContainer,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
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
                  _buildColorPicker(
                    'Primary Container Color',
                    primaryContainer,
                        (color) => _updateThemeColor(
                      isUpdatingDarkTheme: isDarkMode,
                      label: 'Primary Container Color',
                      newColor: color,
                    ),
                  ),
                  _buildColorPicker(
                    'Primary Container Color',
                    primaryContainer,
                        (color) => _updateThemeColor(
                      isUpdatingDarkTheme: isDarkMode,
                      label: 'Primary Container Color',
                      newColor: color,
                    ),
                  ),
                  _buildColorPicker(
                    'On Primary Container Color',
                    onPrimaryContainer,
                        (color) => _updateThemeColor(
                      isUpdatingDarkTheme: isDarkMode,
                      label: 'On Primary Container Color',
                      newColor: color,
                    ),
                  ),
                  _buildColorPicker(
                    'Secondary Container Color',
                    secondaryContainer,
                        (color) => _updateThemeColor(
                      isUpdatingDarkTheme: isDarkMode,
                      label: 'Secondary Container Color',
                      newColor: color,
                    ),
                  ),
                  _buildColorPicker(
                    'On Secondary Container Color',
                    onSecondaryContainer,
                        (color) => _updateThemeColor(
                      isUpdatingDarkTheme: isDarkMode,
                      label: 'On Secondary Container Color',
                      newColor: color,
                    ),
                  ),
                  _buildColorPicker(
                    'Tertiary Container Color',
                    tertiaryContainer,
                        (color) => _updateThemeColor(
                      isUpdatingDarkTheme: isDarkMode,
                      label: 'Tertiary Container Color',
                      newColor: color,
                    ),
                  ),
                  _buildColorPicker(
                    'On Tertiary Container Color',
                    onTertiaryContainer,
                        (color) => _updateThemeColor(
                      isUpdatingDarkTheme: isDarkMode,
                      label: 'On Tertiary Container Color',
                      newColor: color,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: defaultPadding,
              child: _buildNestedContainerPreview(
                primaryContainer: primaryContainer,
                onPrimaryContainer: onPrimaryContainer,
                secondaryContainer: secondaryContainer,
                onSecondaryContainer: onSecondaryContainer,
                tertiaryContainer: tertiaryContainer,
                onTertiaryContainer: onTertiaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNestedContainerPreview({
    required Color primaryContainer,
    required Color onPrimaryContainer,
    required Color secondaryContainer,
    required Color onSecondaryContainer,
    required Color tertiaryContainer,
    required Color onTertiaryContainer,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: defaultPadding,
        color: primaryContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Primary Container',
              style: TextStyle(color: onPrimaryContainer),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: defaultPadding,
              padding: defaultPadding,
              color: secondaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Secondary Container',
                    style: TextStyle(color: onSecondaryContainer),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: defaultPadding,
                    padding: defaultPadding,
                    color: tertiaryContainer,
                    child: Text(
                      'Tertiary Container',
                      style: TextStyle(color: onTertiaryContainer),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        Color tempColor = initialColor;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit "$label"'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: tempColor,
                      onColorChanged: (color) {
                        setState(() {
                          tempColor = color;
                        });
                      },
                      enableAlpha: true,
                      pickerAreaHeightPercent: 0.5,
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
                        onColorChanged(tempColor);
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

  void _updateThemeColor({
    required bool isUpdatingDarkTheme,
    required String label,
    required Color newColor,
  }) {
    setState(() {
      // Determine which theme’s color scheme to update
      if (isUpdatingDarkTheme) {
        _theme = _theme.copyWith(
          darkTheme: _theme.darkTheme.copyWith(
            colorScheme: _updateColorScheme(
              _theme.darkTheme.colorScheme,
              label,
              newColor,
            ),
          ),
        );
      } else {
        _theme = _theme.copyWith(
          lightTheme: _theme.lightTheme.copyWith(
            colorScheme: _updateColorScheme(
              _theme.lightTheme.colorScheme,
              label,
              newColor,
            ),
          ),
        );
      }

      widget.onThemeChange(
        _theme.name,
        {
          'lightPrimaryContainer': _theme.lightTheme.colorScheme.primaryContainer,
          'lightOnPrimaryContainer': _theme.lightTheme.colorScheme.onPrimaryContainer,
          'lightSecondaryContainer': _theme.lightTheme.colorScheme.secondaryContainer,
          'lightOnSecondaryContainer': _theme.lightTheme.colorScheme.onSecondaryContainer,
          'lightTertiaryContainer': _theme.lightTheme.colorScheme.tertiaryContainer,
          'lightOnTertiaryContainer': _theme.lightTheme.colorScheme.onTertiaryContainer,
          'darkPrimaryContainer': _theme.darkTheme.colorScheme.primaryContainer,
          'darkOnPrimaryContainer': _theme.darkTheme.colorScheme.onPrimaryContainer,
          'darkSecondaryContainer': _theme.darkTheme.colorScheme.secondaryContainer,
          'darkOnSecondaryContainer': _theme.darkTheme.colorScheme.onSecondaryContainer,
          'darkTertiaryContainer': _theme.darkTheme.colorScheme.tertiaryContainer,
          'darkOnTertiaryContainer': _theme.darkTheme.colorScheme.onTertiaryContainer,
        },
      );
    });
  }

  ColorScheme _updateColorScheme(ColorScheme scheme, String label, Color newColor) {
    switch (label) {
      case 'Primary Container Color':
        return scheme.copyWith(primaryContainer: newColor);
      case 'On Primary Container Color':
        return scheme.copyWith(onPrimaryContainer: newColor);
      case 'Secondary Container Color':
        return scheme.copyWith(secondaryContainer: newColor);
      case 'On Secondary Container Color':
        return scheme.copyWith(onSecondaryContainer: newColor);
      case 'Tertiary Container Color':
        return scheme.copyWith(tertiaryContainer: newColor);
      case 'On Tertiary Container Color':
        return scheme.copyWith(onTertiaryContainer: newColor);
      default:
        return scheme;
    }
  }
}