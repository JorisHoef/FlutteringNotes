import 'package:flutter/material.dart';
import 'package:fluttering_notes/constants/notes_constants.dart';
import 'package:provider/provider.dart';

import '../states/note_state.dart';

class NoteWritingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var notesState = context.watch<NoteState>();

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(editNoteText),
            ),
          ),
          SliverFillRemaining(
            child: TextField(
              expands: true,
              minLines: null,
              maxLines: null,
              onChanged: (String value) {
                notesState.onNotesChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}