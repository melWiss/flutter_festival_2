import 'package:flutter/material.dart';
import 'package:flutter_festival_2/logic/notes_controller.dart';
import 'package:flutter_festival_2/models/note.dart';
import 'package:flutter_festival_2/pages/view.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  NoteTile({
    required this.note,
    super.key,
  });
  final NotesController notesController = NotesController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ViewNote(
                  note: note,
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(note.title),
            leading: Icon(Icons.note),
            trailing: IconButton(
              onPressed: () {
                notesController.delete(note.id);
              },
              icon: Icon(Icons.close),
            ),
            subtitle: Text(
              note.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
