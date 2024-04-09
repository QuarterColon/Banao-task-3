

import '../models/notes.dart';

abstract class NotesRepository {
  Future<void> addNote(Note note);
  Stream<List<Note>> notes();
}