import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../widgets/big_card.dart';
import '../utils/constants.dart';

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
                label: Text(nextText),
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