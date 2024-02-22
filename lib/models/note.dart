class Note {
  String title;
  String description;

  final int id;

  Note({
    required this.title,
    required this.description,
  }) : id = DateTime.now().microsecondsSinceEpoch;
}
