import 'dart:convert'; // For JSON encoding/decoding
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';
import 'note_repository.dart';

class LocalNoteRepository implements NoteRepository {
  final String _notesKey = "notes"; // Key for storing notes in SharedPreferences

  @override
  Future<List<NoteModel>> getNotes() async {
    final prefs = await SharedPreferences.getInstance(); // Get SharedPreferences instance
    final notesString = prefs.getString(_notesKey); // Retrieve the notes stored as a string

    if (notesString != null) {
      final List<dynamic> notesJson = json.decode(notesString); // Decode JSON string
      return notesJson.map((json) => NoteModel.fromJson(json)).toList(); // Convert JSON to List<Note>
    } else {
      return []; // Return an empty list if no notes are stored
    }
  }

  @override
  Future<void> addNote(NoteModel note) async {
    final prefs = await SharedPreferences.getInstance();
    final currentNotes = await getNotes();
    currentNotes.add(note); // Add the new note to the list
    prefs.setString(
      _notesKey,
      json.encode(currentNotes.map((n) => n.toJson()).toList()), // Convert List<Note> to String
    );
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final prefs = await SharedPreferences.getInstance();
    final currentNotes = await getNotes();

    final index = currentNotes.indexWhere((n) => n.id == note.id); // Find the note by ID
    if (index != -1) {
      currentNotes[index] = note; // Update the existing note
      prefs.setString(
        _notesKey,
        json.encode(currentNotes.map((n) => n.toJson()).toList()), // Save updated list to storage
      );
    }
  }

  @override
  Future<void> deleteNote(int noteId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentNotes = await getNotes();

    currentNotes.removeWhere((n) => n.id == noteId); // Remove note by ID
    prefs.setString(
      _notesKey,
      json.encode(currentNotes.map((n) => n.toJson()).toList()), // Save updated list to storage
    );
  }
}