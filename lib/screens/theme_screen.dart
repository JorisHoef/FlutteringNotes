import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../constants/app_keys.dart';
import '../constants/app_strings.dart';
import '../constants/layout_constants.dart';
import '../models/theme_model.dart';

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
      AppKeys.lightPrimaryContainer: lightScheme.primaryContainer,
      AppKeys.lightOnPrimaryContainer: lightScheme.onPrimaryContainer,
      AppKeys.lightSecondaryContainer: lightScheme.secondaryContainer,
      AppKeys.lightOnSecondaryContainer: lightScheme.onSecondaryContainer,
      AppKeys.lightTertiaryContainer: lightScheme.tertiaryContainer,
      AppKeys.lightOnTertiaryContainer: lightScheme.onTertiaryContainer,
      AppKeys.darkPrimaryContainer: darkScheme.primaryContainer,
      AppKeys.darkOnPrimaryContainer: darkScheme.onPrimaryContainer,
      AppKeys.darkSecondaryContainer: darkScheme.secondaryContainer,
      AppKeys.darkOnSecondaryContainer: darkScheme.onSecondaryContainer,
      AppKeys.darkTertiaryContainer: darkScheme.tertiaryContainer,
      AppKeys.darkOnTertiaryContainer: darkScheme.onTertiaryContainer,
    };
  }

  /// Helper to construct keys for tempColors
  String _getColorKey(String baseKey) {
    return '${isDarkMode ? "dark" : "light"}$baseKey';
  }

  /// Helper to retrieve colors from tempColors by base key
  Color _getColor(String baseKey) {
    return tempColors[_getColorKey(baseKey)]!;
  }

  /// Helper to set colors in tempColors by base key
  void _setColor(String baseKey, Color color) {
    tempColors[_getColorKey(baseKey)] = color;
  }

  /// Helper to retrieve a label for containers
  String _getLabel(String baseKey) {
    switch (baseKey) {
      case AppKeys.primaryContainer:
        return AppStrings.primaryContainer;
      case AppKeys.secondaryContainer:
        return AppStrings.secondaryContainer;
      case AppKeys.tertiaryContainer:
        return AppStrings.tertiaryContainer;
      case AppKeys.onPrimaryContainer:
        return AppStrings.onPrimaryContainer;
      case AppKeys.onSecondaryContainer:
        return AppStrings.onSecondaryContainer;
      case AppKeys.onTertiaryContainer:
        return AppStrings.onTertiaryContainer;
      default:
        return baseKey; // Fallback case
    }
  }

  /// Save the state before popping the screen
  void _saveTheme() {
    debugPrint('Save theme triggered with theme name: ${_theme.name}');

    // Handle empty theme name
    if (_theme.name.isEmpty) {
      debugPrint('Error: Theme name is empty.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.themeNameEmptyError),
        ),
      );
      return; // Don't proceed if the theme name is invalid
    }

    // Call parent callback
    widget.onThemeChange(_theme.name, tempColors);
    debugPrint('onThemeChange callback invoked with theme: ${_theme.name}');
    debugPrint('Updated tempColors: $tempColors');

    // Return the new ThemeModel to the parent
    Navigator.of(context).pop(
      ThemeModel(
        name: _theme.name,
        lightTheme: ThemeModel.buildLightTheme(
          onPrimaryContainer: tempColors[AppKeys.lightOnPrimaryContainer]!,
          onSecondaryContainer: tempColors[AppKeys.lightOnSecondaryContainer]!,
          onTertiaryContainer: tempColors[AppKeys.lightOnTertiaryContainer]!,
          primaryContainer: tempColors[AppKeys.lightPrimaryContainer]!,
          secondaryContainer: tempColors[AppKeys.lightSecondaryContainer]!,
          tertiaryContainer: tempColors[AppKeys.lightTertiaryContainer]!,
          textTheme: _theme.lightTheme.textTheme, // Use existing textTheme
        ),
        darkTheme: ThemeModel.buildDarkTheme(
          onPrimaryContainer: tempColors[AppKeys.darkOnPrimaryContainer]!,
          onSecondaryContainer: tempColors[AppKeys.darkOnSecondaryContainer]!,
          onTertiaryContainer: tempColors[AppKeys.darkOnTertiaryContainer]!,
          primaryContainer: tempColors[AppKeys.darkPrimaryContainer]!,
          secondaryContainer: tempColors[AppKeys.darkSecondaryContainer]!,
          tertiaryContainer: tempColors[AppKeys.darkTertiaryContainer]!,
          textTheme: _theme.darkTheme.textTheme, // Use existing textTheme
        ),
      ),
    );

    debugPrint('Navigator.pop called.');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme =
        isDarkMode ? _theme.darkTheme.textTheme : _theme.lightTheme.textTheme;

    return WillPopScope(
      // Trigger save action before popping the screen
      onWillPop: () async {
        _saveTheme();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: _getColor(AppKeys.onPrimaryContainer),
            ),
            onPressed: _saveTheme,
          ),
          title: TextField(
            controller: TextEditingController(text: _theme.name)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: _theme.name.length),
              ),
            onChanged: (value) {
              setState(() {
                _theme = _theme.copyWith(name: value);
              });
            },
            decoration: InputDecoration(
              hintText: AppStrings.themeNameHint,
              border: InputBorder.none,
              hintStyle: textTheme.bodyLarge?.copyWith(
                color: _getColor(AppKeys.onPrimaryContainer).withOpacity(0.6),
              ),
            ),
            style: textTheme.bodyLarge?.copyWith(
              color: _getColor(AppKeys.onPrimaryContainer),
            ),
          ),
          backgroundColor: _getColor(AppKeys.primaryContainer),
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: _getColor(AppKeys.onPrimaryContainer),
              ),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
        backgroundColor: _getColor(AppKeys.primaryContainer),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: defaultPadding,
                child: _buildNestedContainerPreview(context),
              ),
              Divider(
                color: _getColor(AppKeys.onPrimaryContainer),
              ),
              _buildAllColorPickers(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllColorPickers(BuildContext context) {
    final keys = tempColors.keys
        .where((key) => key.startsWith(isDarkMode ? 'dark' : 'light'));
    final colorScheme = isDarkMode
        ? _theme.darkTheme.colorScheme
        : _theme.lightTheme.colorScheme;
    final textTheme =
        isDarkMode ? _theme.darkTheme.textTheme : _theme.lightTheme.textTheme;

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
                _setColor(label, newColor);
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
        _getLabel(label),
        style: TextStyle(
          color: _getColor(AppKeys.onPrimaryContainer),
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
                  backgroundColor: _getColor(AppKeys.primaryContainer),
                  title: Text(
                    '${AppStrings.editDialogTitle} ${_getLabel(label)}',
                    style: TextStyle(
                      color: _getColor(AppKeys.onPrimaryContainer),
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
                                color: _getColor(label),
                                width: 2,
                              ),
                            ),
                            child: _buildNestedContainerPreview(context),
                          ),
                        ),
                        ColorPicker(
                          pickerColor: _getColor(label),
                          onColorChanged: (newColor) {
                            setState(() {
                              _setColor(label, newColor);
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
                          color: _getColor(AppKeys.onPrimaryContainer),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: Text(
                        AppStrings.applyText,
                        style: TextStyle(
                          color: _getColor(AppKeys.onPrimaryContainer),
                        ),
                      ),
                      onPressed: () {
                        onColorChanged(_getColor(label));
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
    return Container(
      color: _getColor(AppKeys.primaryContainer),
      child: Column(
        children: [
          SizedBox(height: 16),
          Text(
            _getLabel(AppKeys.onPrimaryContainer),
            style: TextStyle(
              color: _getColor(AppKeys.onPrimaryContainer),
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
                color: _getColor(AppKeys.secondaryContainer),
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
                    _getLabel(AppKeys.onSecondaryContainer),
                    style: TextStyle(
                      color: _getColor(AppKeys.onSecondaryContainer),
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
                        color: _getColor(AppKeys.tertiaryContainer),
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
                          _getLabel(AppKeys.onTertiaryContainer),
                          style: TextStyle(
                            color: _getColor(AppKeys.onTertiaryContainer),
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
