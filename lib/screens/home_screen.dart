import 'package:flutter/material.dart';

import '../constants/notes_constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          appName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}