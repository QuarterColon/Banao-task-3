import 'package:banao_task3/bloc/notes_bloc/notes_bloc.dart';
import 'package:banao_task3/models/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_notes_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<bool> showSubtitle = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black26,
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (BuildContext context, NotesState state) {
          if (state is NotesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesLoadedState) {
            return StreamBuilder<List<Note>>(
              stream: state.notes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List<Note> data = snapshot.data!;
                      showSubtitle.add(true);
                      return ExpansionTile(
                        onExpansionChanged: (value) {
                          setState(() {
                            showSubtitle[index] = !value;
                            print(showSubtitle[index]);
                          });
                        },
                        subtitle: showSubtitle[index]
                            ? Text(
                                data[index].description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                        expandedAlignment: Alignment.centerLeft,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        title: Text(
                          data[index].title,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                        builder: (context) => CreateNotesScreen(note: data[index]),
                                      ))
                                      .then(
                                        (value) => BlocProvider.of<NotesBloc>(context).add(LoadNotesEvent()),
                                      );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 18,
                                ),
                                onPressed: () {
                                  BlocProvider.of<NotesBloc>(context).add(RemoveNotesEvent(note: data[index]));
                                },
                              ),
                              SizedBox(width: 4),
                              const Icon(
                                Icons.expand_more,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].description,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Go on and add some notes",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              },
            );
          }
          return const Center(
            child: Text("Go on and add some notes"),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const CreateNotesScreen(),
              ))
              .then(
                (value) => BlocProvider.of<NotesBloc>(context).add(LoadNotesEvent()),
              );
        },
      ),
    );
  }
}
