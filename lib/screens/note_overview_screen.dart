import 'package:flutter/material.dart';
import 'package:fluttering_notes/constants/notes_constants.dart';
import 'package:fluttering_notes/widgets/custom_listTile.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../states/note_state.dart';
import '../screens/note_writing_screen.dart';

class NoteOverviewScreen extends StatelessWidget {
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
              title: Text(overViewNoteText),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final note = notesState.notes[index];
                return CustomListTile(
                    title: note.title,
                    subTitle: note.content,
                    onTapCallback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteWritingScreen(note),
                        ),
                      );
                    }
                );
              },
              childCount: notesState.notes.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newNote = Note(
            id: notesState.notes.length,
            title: newNoteText,
            content: '',
          );
          notesState.addNote(newNote);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteWritingScreen(newNote),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: addNoteText,
      ),
    );
  }
}