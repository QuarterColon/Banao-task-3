part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

class LoadNotesEvent extends NotesEvent {}

class AddNotesEvent extends NotesEvent {
  final Note note;

  AddNotesEvent({required this.note});
}

class RemoveNotesEvent extends NotesEvent {
  final Note note;

  RemoveNotesEvent({required this.note});
}

class EditNotesEvent extends NotesEvent {
  final Note note;

  EditNotesEvent({required this.note});
}
