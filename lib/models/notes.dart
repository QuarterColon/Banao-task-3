
import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String description;

  Note({required this.id, required this.title, required this.description});

    factory Note.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Note(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "title": title,
      "description": description,
    };
  }
}