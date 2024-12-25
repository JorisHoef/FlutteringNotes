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
  late TextTheme textTheme;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _theme = widget.initialTheme;
    textTheme = _theme.lightTheme.textTheme;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _theme.lightTheme;
    final primaryContainer = themeData.colorScheme.primaryContainer;
    final onPrimaryContainer = themeData.colorScheme.onPrimaryContainer;
    final secondaryContainer = themeData.colorScheme.secondaryContainer;
    final onSecondaryContainer = themeData.colorScheme.onSecondaryContainer;
    final tertiaryContainer = themeData.colorScheme.tertiaryContainer;
    final onTertiaryContainer = themeData.colorScheme.onTertiaryContainer;

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
                    setState(() {
                      _theme = _theme.copyWith(
                        lightTheme: _theme.lightTheme.copyWith(
                          colorScheme: _theme.lightTheme.colorScheme.copyWith(
                            primaryContainer: color,
                          ),
                        ),
                      );
                    });
                  }),
                  _buildColorPicker('On Primary Container Color', onPrimaryContainer, (color) {
                    setState(() {
                      _theme = _theme.copyWith(
                        lightTheme: _theme.lightTheme.copyWith(
                          colorScheme: _theme.lightTheme.colorScheme.copyWith(
                            onPrimaryContainer: color,
                          ),
                        ),
                      );
                    });
                  }),
                  _buildColorPicker('Secondary Container Color', secondaryContainer, (color) {
                    setState(() {
                      _theme = _theme.copyWith(
                        lightTheme: _theme.lightTheme.copyWith(
                          colorScheme: _theme.lightTheme.colorScheme.copyWith(
                            secondaryContainer: color,
                          ),
                        ),
                      );
                    });
                  }),
                  _buildColorPicker('On Secondary Container Color', onSecondaryContainer, (color) {
                    setState(() {
                      _theme = _theme.copyWith(
                        lightTheme: _theme.lightTheme.copyWith(
                          colorScheme: _theme.lightTheme.colorScheme.copyWith(
                            onSecondaryContainer: color,
                          ),
                        ),
                      );
                    });
                  }),
                  _buildColorPicker('Tertiary Container Color', tertiaryContainer, (color) {
                    setState(() {
                      _theme = _theme.copyWith(
                        lightTheme: _theme.lightTheme.copyWith(
                          colorScheme: _theme.lightTheme.colorScheme.copyWith(
                            tertiaryContainer: color,
                          ),
                        ),
                      );
                    });
                  }),
                  _buildColorPicker('On Tertiary Container Color', onTertiaryContainer, (color) {
                    setState(() {
                      _theme = _theme.copyWith(
                        lightTheme: _theme.lightTheme.copyWith(
                          colorScheme: _theme.lightTheme.colorScheme.copyWith(
                            onTertiaryContainer: color,
                          ),
                        ),
                      );
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
                return AlertDialog(
                  title: Text('Edit $label'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNestedContainerPreview(
                          primaryContainer: _theme.lightTheme.colorScheme.primaryContainer,
                          onPrimaryContainer: _theme.lightTheme.colorScheme.onPrimaryContainer,
                          secondaryContainer: _theme.lightTheme.colorScheme.secondaryContainer,
                          onSecondaryContainer: _theme.lightTheme.colorScheme.onSecondaryContainer,
                          tertiaryContainer: _theme.lightTheme.colorScheme.tertiaryContainer,
                          onTertiaryContainer: _theme.lightTheme.colorScheme.onTertiaryContainer,
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