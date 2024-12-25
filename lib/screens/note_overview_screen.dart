import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/layout_constants.dart';
import '../models/note_model.dart';
import '../states/note_state.dart';
import '../widgets/listTile_withMenu.dart';
import 'note_writing_screen.dart';

class NoteOverviewScreen extends StatelessWidget {
  late String imageLocation = 'https://picsum.photos/1500/300?grayscale&blur=1';

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
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(
                AppStrings.overViewNoteText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageLocation,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Failed to load image');
                      },
                    ),
                    Positioned(
                      bottom: defaultPadding.bottom - defaultPadding.bottom,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: defaultPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Look at your notes',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                              Text(
                                'They are very pretty',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontWeight: FontWeight.w600,
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
            SliverToBoxAdapter(
              child: Divider(
                height: 1,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                    titleStyle: Theme.of(context).textTheme.bodyMedium,
                    subTitleStyle: Theme.of(context).textTheme.bodySmall,
                    onTap: () {
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
                              '${note.title} ${AppStrings.deletedText}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer
                              ),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
          final newNote = NoteModel(
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
        tooltip: AppStrings.addNoteText,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}