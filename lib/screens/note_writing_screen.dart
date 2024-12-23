import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              title: TextField(
                controller: titleController,
                onChanged: (value) {
                  notesState.updateNote(widget.note.id, title: value);
                },
              ),
            ),
          ),
          SliverFillRemaining(
            child: TextField(
              controller: textController,
              expands: true,
              minLines: null,
              maxLines: null,
              onChanged: (value) {
                notesState.updateNote(widget.note.id, content: value);
              },
            ),
          ),
        ],
      ),
    );
  }
}