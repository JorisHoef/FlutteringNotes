import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/strings_constants.dart';
import 'constants/theme_constants.dart';
import 'screens/home_screen.dart';
import 'states/myapp_state.dart';
import 'states/note_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        ChangeNotifierProvider(create: (context) => NoteState()),
      ],
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        ),
        home: HomePage(),
      ),
    );
  }
}