import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants/layout_constants.dart';
import '../constants/strings_constants.dart';
import '../states/myapp_state.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    List<WordPair> pairs = appState.favorites;

    if (pairs.isEmpty) {
      return Center(
        child: Text(noFavoritesMessage),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text("You have ${pairs.length} favorites:"),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}