import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/notes.dart';
import '../../repositories/firestore_notes_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final FirestoreNotesRepository firestoreNotesRepository;

  NotesBloc(this.firestoreNotesRepository) : super(NotesInitialState()) {
    on<LoadNotesEvent>((event, emit)  {
      emit(NotesLoadingState());
      try {
        final notes = firestoreNotesRepository.notes();
        emit(NotesLoadedState(notes: notes));
      } catch (e) {}
    });
    on<AddNotesEvent>((event, emit) async {
      await firestoreNotesRepository.addNote(event.note);
      add(LoadNotesEvent());
    });
    on<EditNotesEvent>((event, emit) async {
      await firestoreNotesRepository.editNote(event.note);
      add(LoadNotesEvent());
    });
    on<RemoveNotesEvent>((event, emit) async {
      await firestoreNotesRepository.removeNote(event.note.id);
    });

    add(LoadNotesEvent());
  }
}
