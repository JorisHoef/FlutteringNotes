import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/layout_constants.dart';
import '../constants/theme_constants.dart';
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
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              title: Padding(
                padding: defaultPadding,
                child: Text(
                  AppStrings.overViewNoteText,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/your_image.png',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: defaultPadding.bottom-defaultPadding.bottom,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: defaultPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Look at your notes',
                                  style: TextStyle(
                                    fontSize: ThemeValues.fontSizeMedium,
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  'They are very pretty',
                                  style: TextStyle(
                                    fontSize: ThemeValues.fontSizeLarge,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
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
                          content: Text(
                              '${note.title} ${AppStrings.deletedText}'
                          ),
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
        tooltip: AppStrings.addNoteText,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}