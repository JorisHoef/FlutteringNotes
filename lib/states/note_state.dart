import 'package:flutter/widgets.dart';

import '../models/note.dart';

class NoteState extends ChangeNotifier {
  var _currentValue = "";
  List<Note> get notes => _notes;

  List<Note> _notes = [
    Note(title: "Note 1", content: "First Test Note"),
    Note(title: "Note 2", content: "Second Test Note"),
  ];

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void onNotesChanged(String value) {
    print("Old Value: ${_currentValue}");
    print("New Value: ${value}");
    _currentValue = value;
    _saveLocally();
  }

  //TODO: submit notes when app minimizes, closes, sync/submit button pressed, time interval
  void onNotesSubmitted(){
    print("Submitted Notes with value: ${_currentValue}");
    _saveLocally();
    _saveUpload();
  }

  void _saveLocally(){
    print("Not implemented yet");
  }

  void _saveUpload(){
    print("Not Implemented Yet");
  }
}