import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Note {
  String title;
  String description;

  int? _id;

  int get id {
    _id ??= DateTime.now().microsecondsSinceEpoch;

    return _id!;
  }

  Note({
    required this.title,
    required this.description,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: StreamBuilder<Map<int, Note>>(
        stream: notesController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: notesMap.length,
              padding: EdgeInsets.only(bottom: 100),
              itemBuilder: (context, index) {
                return NoteTile(
                  note: Note(
                    description:
                        snapshot.data!.values.elementAt(index).description,
                    title: snapshot.data!.values.elementAt(index).title,
                  ),
                );
              },
            );
          }

          return Center(
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NoteTile extends StatelessWidget {
  final Note note;
  const NoteTile({
    required this.note,
    super.key,
  });

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
                notesMap.remove(note.id);
                notesController.add(notesMap);
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

class ViewNote extends StatelessWidget {
  final Note note;

  const ViewNote({
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
          style: TextStyle(
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

class EditNote extends StatelessWidget {
  Note? note;
  EditNote({this.note});

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
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
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
          notesMap[note!.id] = note!;
          notesController.add(notesMap);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
    );
  }
}

Map<int, Note> notesMap = {};

StreamController<Map<int, Note>> notesController = StreamController();
