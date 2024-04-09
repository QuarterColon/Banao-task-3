import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notes.dart';
import 'firestore_notes_repository.dart';
import 'notes_repository.dart';

class FirestoreNotesRepository implements NotesRepository {
  final noteCollection = FirebaseFirestore.instance.collection('notes');

  @override
  Future<void> addNote(Note note) {
    return noteCollection.add(note.toFireStore());
  }

  @override
  Stream<List<Note>> notes() {
    return noteCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Note.fromFireStore(doc)).toList();
    });
  }

  Future<void> removeNote(String id) {
    return noteCollection.doc(id).delete();
  }

  Future<void> editNote(Note note) {
    return noteCollection.doc(note.id).update(note.toFireStore());
  }
}
