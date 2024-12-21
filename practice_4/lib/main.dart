import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/note_view_model.dart';
import 'views/note_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteViewModel _noteViewModel = NoteViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NoteViewModel>(
      create: (context) => _noteViewModel,
      child: MaterialApp(
        title: 'Заметки',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: NoteListView(),
      ),
    );
  }
}