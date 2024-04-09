part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  final Stream<List<Note>> notes;

  NotesLoadedState({required this.notes});
}
