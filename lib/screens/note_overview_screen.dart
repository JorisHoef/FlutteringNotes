import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../constants/strings_constants.dart';
import '../states/note_state.dart';

class NoteOverviewPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var notesState = context.watch<NoteState>();

    return CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(appName),
            ),
          ),
          //TODO: implement saving notes and showing them here in a grid/list
        ]
    );
  }
}