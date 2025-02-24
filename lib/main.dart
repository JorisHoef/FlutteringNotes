import 'package:flutter/material.dart';
import 'package:fluttering_notes/storage/local_theme_repository.dart';
import 'package:provider/provider.dart';

import 'constants/app_strings.dart';
import 'providers/animation_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/main_screen.dart';
import 'states/note_state.dart';
import 'storage/local_note_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteState(LocalNoteRepository())..loadNotes(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(LocalThemeRepository()),
        ),
        ChangeNotifierProvider(
            create: (_) => AnimationProvider()),
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
          theme: themeProvider.themeData,

          // Wrap all screens globally with SafeArea
          builder: (context, child) {
            return SafeArea(
              child: child ?? const SizedBox.shrink(),
            );
          },

          home: MainScreen(),
        );
      },
    );
  }
}
