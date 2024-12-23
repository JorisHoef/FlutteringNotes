import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/notes_constants.dart';
import '../models/note.dart';
import '../states/note_state.dart';
import '../widgets/listTile_withMenu.dart';
import 'note_writing_screen.dart';

class NoteOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var notesState = context.watch<NoteState>();

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 50.0, //todo probably remove but keep for test
            flexibleSpace: FlexibleSpaceBar(
              title: Text(overViewNoteText),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final note = notesState.notes[index];
                return ListTileWithMenu(
                  title: note.title,
                  subTitle: note.content,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteWritingScreen(note),
                      ),
                    );
                  },
                  onDelete: () {
                    notesState.deleteNote(note);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${note.title} ${deletedText}'),
                      ),
                    );
                  },
                );
              },
              childCount: notesState.notes.length,
            ),
          ),
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newNote = Note(
            id: notesState.notes.length,
            title: '',
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