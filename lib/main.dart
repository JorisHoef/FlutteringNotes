import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_strings.dart';
import 'screens/main_screen.dart';
import 'states/note_state.dart';
import 'storage/local_note_repository.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async operations before app starts

  runApp(
    MultiProvider(
      providers: [
        // NoteState with LocalNoteRepository
        ChangeNotifierProvider(
          create: (context) => NoteState(LocalNoteRepository())..loadNotes(),
        ),
        // ThemeProvider (initialization handled internally)
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(), // No explicit `loadThemeFromPrefs` here
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: AppStrings.appName,
          theme: themeProvider.themeData, // Dynamically gets applied theme
          home: MainScreen(), // Entry screen of the app
        );
      },
    );
  }
}