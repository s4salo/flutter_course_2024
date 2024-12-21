import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteViewModel with ChangeNotifier {
  Note _note;

  NoteViewModel(this._note);

  String get id => _note.id;
  String get title => _note.title;
  String get content => _note.content;
  ImageProvider? get image => _note.image;

  ImageProvider get displayImage {
    return _note.image ?? AssetImage('assets/default_image.png');
  }

  set title(String value) {
    _note.title = value;
    notifyListeners();
  }

  set content(String value) {
    _note.content = value;
    notifyListeners();
  }

  set image(ImageProvider? value) {
    _note.image = value;
    notifyListeners();
  }

  bool get isValid {
    return _note.title.isNotEmpty;
  }
}