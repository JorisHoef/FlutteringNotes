import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/notes_constants.dart';
import 'screens/main_screen.dart';
import 'states/note_state.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteState()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: appName,
            theme: themeProvider.currentTheme,
            home: MainScreen(),
          );
        },
      ),
    );
  }
}