import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/layout_constants.dart';
import '../models/note.dart';
import '../states/note_state.dart';

class NoteWritingScreen extends StatefulWidget {
  final Note note;

  NoteWritingScreen(this.note);

  @override
  _NoteWritingScreenState createState() => _NoteWritingScreenState();
}

class _NoteWritingScreenState extends State<NoteWritingScreen> {
  late TextEditingController titleController;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    textController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    super.dispose();
  }

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
              expandedHeight: 50.0,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: Padding(
                padding: defaultPadding,
                child: TextField(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  controller: titleController,
                  onChanged: (value) {
                    notesState.updateNote(widget.note.id, title: value);
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.noteTitlePlaceholder,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: TextField(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                controller: textController,
                expands: true,
                minLines: null,
                maxLines: null,
                onChanged: (value) {
                  notesState.updateNote(widget.note.id, content: value);
                },
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  hintText: AppStrings.noteTextPlaceholder,
                  border: InputBorder.none,
                  contentPadding: defaultPadding,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}