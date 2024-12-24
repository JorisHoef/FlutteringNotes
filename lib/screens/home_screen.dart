import 'package:flutter/material.dart';

import '../constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppStrings.appName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}