import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_view_model.dart';
import '../viewmodels/notes_list_view_model.dart';
import '../models/note.dart';

class NoteView extends StatefulWidget {
  final String? noteId;

  NoteView({this.noteId});

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  NoteViewModel? _noteVM;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool isNewNote = false;
  bool isTitleNotEmpty = false;

  @override
  void initState() {
    super.initState();
    final notesListVM = Provider.of<NotesListViewModel>(context, listen: false);
    if (widget.noteId != null) {
      _noteVM = notesListVM.getNoteById(widget.noteId!)!;
      _titleController.text = _noteVM!.title;
      _contentController.text = _noteVM!.content;
    } else {
      isNewNote = true;
      _noteVM = NoteViewModel(Note(
        id: DateTime.now().toString(),
        title: '',
        content: '',
      ));
    }

    _titleController.addListener(() {
      setState(() {
        isTitleNotEmpty = _titleController.text.isNotEmpty;
      });
    });
  }

  void _saveNote() {
    _noteVM!.title = _titleController.text;
    _noteVM!.content = _contentController.text;
    if (_noteVM!.isValid) {
      final notesListVM = Provider.of<NotesListViewModel>(context, listen: false);

      if (isNewNote) {
        notesListVM.addNoteViewModel(_noteVM!);
        isNewNote = false;
      }
    }
  }

  @override
  void dispose() {
    _saveNote();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 600,
    );
    if (imageFile != null) {
      setState(() {
        _noteVM!.image = FileImage(File(imageFile.path));
      });
    }
  }

  void _deleteNote() {
    final notesListVM = Provider.of<NotesListViewModel>(context, listen: false);
    notesListVM.removeNoteById(_noteVM!.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _saveNote();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          title: Text('Предмет'),
          backgroundColor: Colors.deepPurple,
          actions: [
            if (!isNewNote)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _deleteNote,
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: _noteVM!.image != null
                    ? Image(
                  image: _noteVM!.image!,
                  fit: BoxFit.cover,
                )
                    : Image(
                  image: AssetImage('assets/default_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: _pickImage,
                child: Text('Добавить изображение'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _titleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Название',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _contentController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Текст',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}