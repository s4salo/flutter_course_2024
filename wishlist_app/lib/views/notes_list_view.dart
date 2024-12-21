import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_view_model.dart';
import '../viewmodels/notes_list_view_model.dart';
import '../widgets/note_card.dart';
import 'note_view.dart';

class NotesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<NotesListViewModel>(
        builder: (context, notesListVM, child) {
          if (notesListVM.notes.isEmpty) {
            return Center(
              child: Text(
                'Список желаний пуст',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: notesListVM.notes.length,
            itemBuilder: (context, index) {
              final noteVM = notesListVM.notes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteView(noteId: noteVM.id),
                    ),
                  );
                },
                child: NoteCard(noteVM: noteVM),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NoteView(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}