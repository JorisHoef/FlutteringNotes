import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../states/myapp_state.dart';
import '../widgets/big_card.dart';
import '../constants//strings_constants.dart';
import '../constants//layout_constants.dart';

class WordGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: defaultBoxWidthHeight),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text(favoriteText),
              ),
              SizedBox(width: defaultBoxWidthHeight),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text(nextText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}