import 'package:flutter/material.dart';
import '../viewmodels/note_view_model.dart';

class NoteCard extends StatelessWidget {
  final NoteViewModel noteVM;

  NoteCard({required this.noteVM});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
              child: Image(
                image: noteVM.displayImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              noteVM.title,
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}