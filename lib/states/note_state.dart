import 'package:flutter/material.dart';
import '../models/note.dart';

import '../storage/note_repository.dart';

class NoteState extends ChangeNotifier {
  final NoteRepository repository;

  NoteState(this.repository);

  // List to hold the current notes in memory
  List<Note> _notes = [];

  // Public getter to access notes (read-only outside this class)
  List<Note> get notes => List.unmodifiable(_notes);

  // Loader to check if notes are still being loaded (optional, useful for showing a persistent loader)
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Fetch notes from the repository and initialize the notes list
  Future<void> loadNotes() async {
    _isLoading = true; // Set loading to true
    notifyListeners();

    _notes = await repository.getNotes(); // Fetch notes from the repository
    _isLoading = false; // Set loading to false
    notifyListeners(); // Notify the provider to update UI
  }

  // Add a new note and persist it through the repository
  Future<void> addNote(Note newNote) async {
    await repository.addNote(newNote); // Add note to the repository
    _notes.add(newNote); // Add note to the in-memory list
    notifyListeners(); // Notify listeners about the change
  }

  // Update an existing note
  Future<void> updateNote(int noteId, {String? title, String? content}) async {
    int index = _notes.indexWhere((note) => note.id == noteId);

    if (index != -1) {
      final updatedNote = _notes[index].copyWith(title: title, content: content); // Create an updated Note
      await repository.updateNote(updatedNote); // Update the note in the repository
      _notes[index] = updatedNote; // Update the note in memory
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Delete a note
  Future<void> deleteNote(Note note) async {
    await repository.deleteNote(note.id); // Delete the note from the repository
    _notes.removeWhere((n) => n.id == note.id); // Remove note from the in-memory list
    notifyListeners(); // Notify listeners about the change
  }
}