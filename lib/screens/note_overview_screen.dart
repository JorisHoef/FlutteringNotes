import 'package:flutter/material.dart';
import 'package:fluttering_notes/constants/notes_constants.dart';
import 'package:provider/provider.dart';

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
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteWritingScreen(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteWritingScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: addNoteText,
      ),
    );
  }
}