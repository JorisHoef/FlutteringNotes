import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();

    // Initial theme values
    textTheme = ThemeData.light().textTheme;
    onPrimaryContainer = Colors.blue;
    onSecondaryContainer = Colors.green;
    onTertiaryContainer = Colors.orange;
    tertiaryContainer = Colors.orangeAccent;
    primaryContainer = Colors.blueAccent;
    secondaryContainer = Colors.greenAccent;

    // Create the initial theme model
    currentTheme = ThemeModel(
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

  void _updateTheme() {
    setState(() {
      currentTheme = ThemeModel(
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
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Preview'),
        backgroundColor: currentTheme.lightTheme.colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Theme Color Pickers
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ColorPicker(
                    label: 'Primary Container Color',
                    color: onPrimaryContainer,
                    onChanged: (value) {
                      setState(() {
                        onPrimaryContainer = value;
                        _updateTheme();
                      });
                    },
                  ),
                  ColorPicker(
                    label: 'Secondary Container Color',
                    color: onSecondaryContainer,
                    onChanged: (value) {
                      setState(() {
                        onSecondaryContainer = value;
                        _updateTheme();
                      });
                    },
                  ),
                  ColorPicker(
                    label: 'Tertiary Container Color',
                    color: onTertiaryContainer,
                    onChanged: (value) {
                      setState(() {
                        onTertiaryContainer = value;
                        _updateTheme();
                      });
                    },
                  ),
                  // Add more ColorPickers as needed for other theme properties
                ],
              ),
            ),
            Divider(),
            // Preview the theme
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16),
                color: currentTheme.lightTheme.colorScheme.primaryContainer,
                child: Column(
                  children: [
                    Text(
                      'Theme Preview',
                      style: currentTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: currentTheme.lightTheme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Primary Text Color',
                        style: currentTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: currentTheme.lightTheme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Secondary Text Color',
                        style: currentTheme.lightTheme.textTheme.bodySmall?.copyWith(
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
}

class ColorPicker extends StatelessWidget {
  final String label;
  final Color color;
  final ValueChanged<Color> onChanged;

  const ColorPicker({
    Key? key,
    required this.label,
    required this.color,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double red = (color.red).toDouble();
    double green = (color.green).toDouble();
    double blue = (color.blue).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            _buildSlider("Red", red, (value) {
              onChanged(Color.fromRGBO(value.toInt(), color.green, color.blue, 1.0));
            }),
            _buildSlider("Green", green, (value) {
              onChanged(Color.fromRGBO(color.red, value.toInt(), color.blue, 1.0));
            }),
            _buildSlider("Blue", blue, (value) {
              onChanged(Color.fromRGBO(color.red, color.green, value.toInt(), 1.0));
            }),
          ],
        ),
        Container(
          width: 50,
          height: 50,
          color: color,
        ),
      ],
    );
  }

  Widget _buildSlider(String label, double colorValue, ValueChanged<double> onChanged) {
    return Expanded(
      child: Column(
        children: [
          Text(label),
          Slider(
            value: colorValue,
            min: 0.0,
            max: 255.0, // RGB values range from 0 to 255
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}