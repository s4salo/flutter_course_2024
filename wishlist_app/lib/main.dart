import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/notes_list_view_model.dart';
import 'views/notes_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    hintColor: Colors.deepPurpleAccent,
    textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesListViewModel(),
      child: MaterialApp(
        title: 'Wishlist App',
        theme: theme,
        home: NotesListView(),
      ),
    );
  }
}