import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/strings_constants.dart';
import '../states/note_state.dart';

class NoteOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              final note = notesState.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                onTap: () {
                  //TODO: Go to detail page/Open note?
                },
              );
            },
            childCount: notesState.notes.length,
          ),
        ),
      ],
    );
  }
}