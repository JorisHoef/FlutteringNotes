import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_strings.dart';
import 'screens/main_screen.dart';
import 'states/note_state.dart';
import 'storage/local_note_repository.dart';
import 'themes/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Initialize NoteState with LocalNoteRepository
        ChangeNotifierProvider(
          create: (context) => NoteState(LocalNoteRepository())..loadNotes(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: AppStrings.appName,
            theme: themeProvider.themeData,
            home: MainScreen(), // The main entry-point screen
          );
        },
      ),
    );
  }
}