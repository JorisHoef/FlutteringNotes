import 'package:flutter/widgets.dart';

import '../models/note.dart';

class NoteState extends ChangeNotifier {
  List<Note> get notes => _notes;

  List<Note> _notes = [
    Note(title: "Note 1", content: "First Test Note"),
    Note(title: "Note 2", content: "Second Test Note"),
  ];

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void onTitleChanged(Note note, String value){
    //note.title = value;
    notifyListeners();
  }

  void onContentChanged(Note note, String value) {
    //note.content = value;
    notifyListeners();
  }
}