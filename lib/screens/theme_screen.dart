import 'package:flutter/material.dart';
import 'package:fluttering_notes/constants/layout_constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../themes/theme_manager.dart';

class ThemeScreen extends StatefulWidget {
  final ThemeModel initialTheme;

  ThemeScreen({required this.initialTheme});

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
    // Use the correct theme based on the current mode (light or dark)
    final themeData = isDarkMode ? _theme.darkTheme : _theme.lightTheme;

    // Get color values from the color scheme of the active theme
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
                  _buildColorPicker('Primary Container Color', primaryContainer, (color) {
                    _updateThemeColor(isDarkMode, (colorScheme) {
                      return colorScheme.copyWith(primaryContainer: color);
                    });
                  }),
                  _buildColorPicker('On Primary Container Color', onPrimaryContainer, (color) {
                    _updateThemeColor(isDarkMode, (colorScheme) {
                      return colorScheme.copyWith(onPrimaryContainer: color);
                    });
                  }),
                  _buildColorPicker('Secondary Container Color', secondaryContainer, (color) {
                    _updateThemeColor(isDarkMode, (colorScheme) {
                      return colorScheme.copyWith(secondaryContainer: color);
                    });
                  }),
                  _buildColorPicker('On Secondary Container Color', onSecondaryContainer, (color) {
                    _updateThemeColor(isDarkMode, (colorScheme) {
                      return colorScheme.copyWith(onSecondaryContainer: color);
                    });
                  }),
                  _buildColorPicker('Tertiary Container Color', tertiaryContainer, (color) {
                    _updateThemeColor(isDarkMode, (colorScheme) {
                      return colorScheme.copyWith(tertiaryContainer: color);
                    });
                  }),
                  _buildColorPicker('On Tertiary Container Color', onTertiaryContainer, (color) {
                    _updateThemeColor(isDarkMode, (colorScheme) {
                      return colorScheme.copyWith(onTertiaryContainer: color);
                    });
                  }),
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

  void _updateThemeColor(bool isDarkMode, ColorScheme Function(ColorScheme) colorSchemeUpdater) {
    setState(() {
      if (isDarkMode) {
        _theme = _theme.copyWith(
          darkTheme: _theme.darkTheme.copyWith(
            colorScheme: colorSchemeUpdater(_theme.darkTheme.colorScheme),
          ),
        );
      } else {
        _theme = _theme.copyWith(
          lightTheme: _theme.lightTheme.copyWith(
            colorScheme: colorSchemeUpdater(_theme.lightTheme.colorScheme),
          ),
        );
      }
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
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                final themeData = isDarkMode ? _theme.darkTheme : _theme.lightTheme;
                final colorScheme = themeData.colorScheme;

                return AlertDialog(
                  title: Text('Edit $label'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNestedContainerPreview(
                          primaryContainer: colorScheme.primaryContainer,
                          onPrimaryContainer: colorScheme.onPrimaryContainer,
                          secondaryContainer: colorScheme.secondaryContainer,
                          onSecondaryContainer: colorScheme.onSecondaryContainer,
                          tertiaryContainer: colorScheme.tertiaryContainer,
                          onTertiaryContainer: colorScheme.onTertiaryContainer,
                        ),
                        SizedBox(height: 20),
                        ColorPicker(
                          pickerColor: initialColor,
                          onColorChanged: (color) {
                            setState(() {
                              // Update the color in the parent state
                              onColorChanged(color);
                            });
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
}