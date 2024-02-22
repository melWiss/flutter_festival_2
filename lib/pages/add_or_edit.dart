import 'package:flutter/material.dart';
import 'package:flutter_festival_2/logic/notes_controller.dart';
import 'package:flutter_festival_2/models/note.dart';

class EditNote extends StatelessWidget {
  Note? note;
  EditNote({
    super.key,
    this.note,
  });

  final NotesController notesController = NotesController();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: note?.title);
    TextEditingController descriptionController =
        TextEditingController(text: note?.description);
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note: ${note!.title}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (note == null) {
            note = Note(
              title: titleController.text,
              description: descriptionController.text,
            );
          } else {
            note!.title = titleController.text;
            note!.description = descriptionController.text;
          }

          notesController.addOrEdit(note!);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
