import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../constants/layout_constants.dart';
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
  late Map<String, Color> tempColors;

  @override
  void initState() {
    super.initState();
    _theme = widget.initialTheme;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Preview'),
        backgroundColor: tempColors['${isDarkMode ? 'dark' : 'light'}PrimaryContainer']!,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() => isDarkMode = !isDarkMode);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: defaultPadding,
              child: _buildNestedContainerPreview(), // Display the preview container
            ),
            Divider(),
            _buildAllColorPickers(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllColorPickers() {
    final keys = tempColors.keys.where((key) =>
        key.startsWith(isDarkMode ? 'dark' : 'light'));

    return Padding(
      padding: defaultPadding,
      child: Column(
        children: keys.map((key) {
          final color = tempColors[key]!;
          final label = key.replaceFirst('${isDarkMode ? 'dark' : 'light'}', '');

          return _buildColorPicker(
            label,
            color,
                (newColor) {
              setState(() {
                tempColors[key] = newColor;
              });
            },
          );
        }).toList(),
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

        // Open a popup for the color picker
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('Edit $label'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 370,
                            child: _buildNestedContainerPreview(),
                            decoration: BoxDecoration(
                              border: Border.all(color: tempColor, width: 2),
                            ),
                          ),
                        ),
                        ColorPicker(
                          pickerColor: tempColor,
                          onColorChanged: (newColor) {
                            setState(() {
                              tempColor = newColor;

                              // Update tempColors dynamically for live updates
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
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('Select'),
                      onPressed: () {
                        onColorChanged(tempColor); // Commit the final changes
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

  Widget _buildNestedContainerPreview() {
    // Constructs the container preview dynamically from tempColors
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
    widget.onThemeChange(
      _theme.name,
      tempColors,
    );
    super.dispose();
  }
}