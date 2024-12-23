import 'package:flutter/material.dart';
import 'package:fluttering_notes/models/note.dart';
import 'package:provider/provider.dart';

import '../states/note_state.dart';

class NoteWritingScreen extends StatelessWidget {
  final Note note;

  NoteWritingScreen(this.note);

  @override
  Widget build(BuildContext context) {
    var notesState = context.watch<NoteState>();

    final TextEditingController titleController = TextEditingController(text: note.title);
    final TextEditingController textController = TextEditingController(text: note.content);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              title: TextField(
                controller: titleController,
              )
              ,
            ),
          ),
          SliverFillRemaining(
            child: TextField(
              controller: textController,
              expands: true,
              minLines: null,
              maxLines: null,
              onChanged: (String value) {
                notesState.onContentChanged(note, value);
              },
            ),
          ),
        ],
      ),
    );
  }
}