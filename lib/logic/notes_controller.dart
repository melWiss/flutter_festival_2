import 'dart:async';

import 'package:flutter_festival_2/models/note.dart';

class NotesController {
  final Map<int, Note> _notesMap = {};

  static NotesController _instance = NotesController._private();

  StreamController<Map<int, Note>> controller = StreamController();

  factory NotesController() {
    return _instance;
  }

  NotesController._private() {
    controller.add(_notesMap);
  }

  void addOrEdit(Note note) {
    _notesMap[note.id] = note;
    controller.add(_notesMap);
  }

  void delete(int id) {
    _notesMap.remove(id);
    controller.add(_notesMap);
  }

  Note? getBytID(int id) {
    return _notesMap[id];
  }
}
