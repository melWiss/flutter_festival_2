import 'package:flutter/material.dart';
import 'package:flutter_festival_2/logic/notes_controller.dart';
import 'package:flutter_festival_2/models/note.dart';
import 'package:flutter_festival_2/pages/add_or_edit.dart';
import 'package:flutter_festival_2/widgets/note_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotesController notesController = NotesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<Map<int, Note>>(
        stream: notesController.controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No note for now"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.only(bottom: 100),
              itemBuilder: (context, index) {
                return NoteTile(
                  note: snapshot.data!.values.elementAt(index),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EditNote(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
