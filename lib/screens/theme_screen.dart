import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/layout_constants.dart';
import '../themes/theme_manager.dart';
import '../themes/theme_provider.dart';

class ThemeScreen extends StatefulWidget {
  final ThemeModel initialTheme;
  final bool initialIsDarkMode;
  final Function(String themeName, Map<String, Color>) onThemeChange;

  ThemeScreen({
    required this.initialTheme,
    required this.initialIsDarkMode,
    required this.onThemeChange,
  });

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late ThemeModel _theme;
  late bool isDarkMode;
  late Map<String, Color> tempColors;

  @override
  void initState() {
    super.initState();
    _theme = widget.initialTheme;
    isDarkMode = widget.initialIsDarkMode;
    _initializeTempColors();
  }

  void _initializeTempColors() {
    final lightScheme = _theme.lightTheme.colorScheme;
    final darkScheme = _theme.darkTheme.colorScheme;

    tempColors = {
      'lightPrimaryContainer': lightScheme.primaryContainer,
      'lightOnPrimaryContainer': lightScheme.onPrimaryContainer,
      'lightSecondaryContainer': lightScheme.secondaryContainer,
      'lightOnSecondaryContainer': lightScheme.onSecondaryContainer,
      'lightTertiaryContainer': lightScheme.tertiaryContainer,
      'lightOnTertiaryContainer': lightScheme.onTertiaryContainer,
      'darkPrimaryContainer': darkScheme.primaryContainer,
      'darkOnPrimaryContainer': darkScheme.onPrimaryContainer,
      'darkSecondaryContainer': darkScheme.secondaryContainer,
      'darkOnSecondaryContainer': darkScheme.onSecondaryContainer,
      'darkTertiaryContainer': darkScheme.tertiaryContainer,
      'darkOnTertiaryContainer': darkScheme.onTertiaryContainer,
    };
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = isDarkMode ? _theme.darkTheme.textTheme : _theme.lightTheme.textTheme;

    return WillPopScope(
      onWillPop: () async {
        widget.onThemeChange(_theme.name, tempColors);
        context.read<ThemeProvider>().switchTheme(_theme.name);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer']!,
            ),
            onPressed: () {
              widget.onThemeChange(_theme.name, tempColors);
              context.read<ThemeProvider>().switchTheme(_theme.name);
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            AppStrings.themePreview,
            style: textTheme.bodyLarge?.copyWith(
              color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer'],
            ),
          ),
          backgroundColor: tempColors['${isDarkMode ? 'dark' : 'light'}PrimaryContainer']!,
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer']!,
              ),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
        backgroundColor: tempColors['${isDarkMode ? 'dark' : 'light'}PrimaryContainer']!,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: defaultPadding,
                child: _buildNestedContainerPreview(context),
              ),
              Divider(
                color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer']!,
              ),
              _buildAllColorPickers(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllColorPickers(BuildContext context) {
    final keys = tempColors.keys.where((key) =>
        key.startsWith(isDarkMode ? 'dark' : 'light'));
    final colorScheme = isDarkMode ? _theme.darkTheme.colorScheme : _theme.lightTheme.colorScheme;
    final textTheme = isDarkMode ? _theme.darkTheme.textTheme : _theme.lightTheme.textTheme;

    return Padding(
      padding: defaultPadding,
      child: Column(
        children: keys.map((key) {
          final color = tempColors[key]!;
          final label = key.replaceFirst(isDarkMode ? 'dark' : 'light', '');

          return _buildColorPicker(
            label,
            color,
                (newColor) {
              setState(() {
                tempColors[key] = newColor;
              });
            },
            textTheme,
            colorScheme,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildColorPicker(
      String label,
      Color initialColor,
      ValueChanged<Color> onColorChanged,
      TextTheme textTheme,
      ColorScheme colorScheme,
      ) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer'],
          fontSize: textTheme.bodyMedium?.fontSize,
        ),
      ),
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
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  backgroundColor: tempColors['${isDarkMode ? 'dark' : 'light'}PrimaryContainer'],
                  title: Text(
                    '${AppStrings.editText} $label',
                    style: TextStyle(
                      color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer'],
                      fontSize: textTheme.titleMedium?.fontSize,
                      fontWeight: textTheme.titleMedium?.fontWeight,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 370,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: tempColors['${isDarkMode ? 'dark' : 'light'}$label'] ?? initialColor,
                                width: 2,
                              ),
                            ),
                            child: _buildNestedContainerPreview(context),
                          ),
                        ),
                        ColorPicker(
                          pickerColor: tempColors['${isDarkMode ? 'dark' : 'light'}$label'] ?? initialColor,
                          onColorChanged: (newColor) {
                            setState(() {
                              tempColors['${isDarkMode ? 'dark' : 'light'}$label'] = newColor;
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
                      child: Text(
                        AppStrings.cancelText,
                        style: TextStyle(
                          color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer'],
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: Text(
                        AppStrings.applyText,
                        style: TextStyle(
                          color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer'],
                        ),
                      ),
                      onPressed: () {
                        onColorChanged(tempColors['${isDarkMode ? 'dark' : 'light'}$label'] ?? initialColor);
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

  Widget _buildNestedContainerPreview(BuildContext context) {
    final colorScheme = isDarkMode ? _theme.darkTheme.colorScheme : _theme.lightTheme.colorScheme;

    return Container(
      color: tempColors['${isDarkMode ? 'dark' : 'light'}PrimaryContainer'],
      child: Column(
        children: [
          SizedBox(height: 16),
          Text(
            'Primary Container',
            style: TextStyle(
              color: tempColors['${isDarkMode ? 'dark' : 'light'}OnPrimaryContainer'],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: tempColors['${isDarkMode ? 'dark' : 'light'}SecondaryContainer'],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Secondary Container',
                    style: TextStyle(
                      color: tempColors['${isDarkMode ? 'dark' : 'light'}OnSecondaryContainer'],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: tempColors['${isDarkMode ? 'dark' : 'light'}TertiaryContainer'],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Tertiary Container',
                          style: TextStyle(
                            color: tempColors['${isDarkMode ? 'dark' : 'light'}OnTertiaryContainer'],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}