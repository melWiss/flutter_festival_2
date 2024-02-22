import 'package:flutter/material.dart';
import 'package:flutter_festival_2/models/note.dart';
import 'package:flutter_festival_2/pages/add_or_edit.dart';

class ViewNote extends StatelessWidget {
  final Note note;

  const ViewNote({
    super.key,
    required this.note,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          note.description,
          style: const TextStyle(
            fontSize: 35,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EditNote(
                note: note,
              ),
            ),
          );
        },
        label: Text("Edit"),
        icon: Icon(Icons.edit),
      ),
    );
  }
}
