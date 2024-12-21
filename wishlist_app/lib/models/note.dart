import 'package:flutter/material.dart';

class Note {
  String id;
  String title;
  String content;
  ImageProvider? image;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.image,
  });
}