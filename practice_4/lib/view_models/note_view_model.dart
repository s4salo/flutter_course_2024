import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteViewModel extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(int index, Note note) {
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNoteAt(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}