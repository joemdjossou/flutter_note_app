import 'package:flutter/cupertino.dart';
import 'package:flutter_note_app/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  static bool _initialized = false;

  //INITIALIZE the Database
  static Future<void> initialize() async {
    if (!_initialized){
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
          [NoteSchema],
          directory: dir.path
      );
    }
    _initialized = true;
  }

  //list of notes
  final List<Note> currentNotes = [];

  //CREATE -A note is saved into the database
  Future<void> addNote(String textFromUser) async {
    // create a new note object
    final newNote = Note()..text = textFromUser;

    //save the note into the db
    await isar.writeTxn(() async => isar.notes.put(newNote));

    // Notify listeners after the database update.
    await fetchNotes();
  }

  //READ -A note is retrieved from the database
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }
  //UPDATE -A note is updated inside the database
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //DELETE -A note is deleted from the database
  Future<void> deleteNote(int id) async {
      await isar.writeTxn(() => isar.notes.delete(id));
      await fetchNotes();
  }

}