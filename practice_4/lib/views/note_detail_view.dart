import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../view_models/note_view_model.dart';

class NoteDetailView extends StatefulWidget {
  final Note? note;
  final int? noteIndex;

  const NoteDetailView({Key? key, this.note, this.noteIndex}) : super(key: key);

  @override
  _NoteDetailViewState createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;

  @override
  void initState() {
    super.initState();
    _title = widget.note?.title ?? '';
    _content = widget.note?.content ?? '';
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final noteViewModel =
      Provider.of<NoteViewModel>(context, listen: false);

      if (widget.note == null) {
        // Добавление новой заметки
        noteViewModel.addNote(Note(title: _title, content: _content));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Заметка добавлена')),
        );
      } else {
        // Обновление существующей заметки
        noteViewModel.updateNote(
          widget.noteIndex!,
          Note(title: _title, content: _content),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Заметка обновлена')),
        );
      }

      Navigator.pop(context);
    }
  }

  void _deleteNote() {
    final noteViewModel =
    Provider.of<NoteViewModel>(context, listen: false);
    noteViewModel.deleteNoteAt(widget.noteIndex!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Заметка удалена')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text(widget.note != null ? 'Редактировать Заметку' : 'Новая Заметка'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
            tooltip: 'Сохранить',
          ),
          if (widget.note != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Удалить заметку?'),
                    content: Text('Вы уверены, что хотите удалить эту заметку?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Закрыть диалог
                        },
                        child: Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Закрыть диалог
                          _deleteNote();
                        },
                        child: Text('Удалить'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'Удалить',
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade50, Colors.indigo.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _title,
                  decoration: InputDecoration(
                    labelText: 'Название',
                    labelStyle: TextStyle(color: Colors.indigo),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  style: TextStyle(fontSize: 24.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите название заметки';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value ?? '',
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: TextFormField(
                    initialValue: _content,
                    decoration: InputDecoration(
                      labelText: 'Содержание',
                      labelStyle: TextStyle(color: Colors.indigo),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                      ),
                    ),
                    style: TextStyle(fontSize: 18.0),
                    maxLines: null,
                    expands: true,
                    onSaved: (value) => _content = value ?? '',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}