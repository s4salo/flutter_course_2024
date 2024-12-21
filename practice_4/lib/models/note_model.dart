import './note.dart';

class NoteModel {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(Note note) {
    _notes.add(note);
  }

  void updateNote(int index, Note note) {
    _notes[index] = note;
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
  }
}