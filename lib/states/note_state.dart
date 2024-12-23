import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteState extends ChangeNotifier {
  List<Note> _notes = [
    Note(id: 0, title: "Note 1", content: "First Test Note"),
    Note(id: 1, title: "Note 2", content: "Second Test Note"),
  ];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(int noteId, {String? title, String? content}) {
    int index = _notes.indexWhere((note) => note.id == noteId);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(title: title, content: content);
      notifyListeners();
    }
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }
}