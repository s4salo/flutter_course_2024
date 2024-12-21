import 'package:flutter/material.dart';
import 'note_view_model.dart';

class NotesListViewModel with ChangeNotifier {
  List<NoteViewModel> notes = [];

  void addNoteViewModel(NoteViewModel noteVM) {
    notes.add(noteVM);
    notifyListeners();
  }

  void removeNoteById(String id) {
    notes.removeWhere((noteVM) => noteVM.id == id);
    notifyListeners();
  }

  NoteViewModel? getNoteById(String id) {
    try {
      return notes.firstWhere((noteVM) => noteVM.id == id);
    } catch (e) {
      return null;
    }
  }
}