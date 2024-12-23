import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/notes_constants.dart';
import 'constants/theme_constants.dart';
import 'screens/main_screen.dart';
import 'states/note_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteState()),
      ],
      child: MaterialApp(
        title: appName,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,//ThemeMode.system,
        home: MainScreen(),
      ),
    );
  }
}