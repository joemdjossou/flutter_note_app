import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/note_database.dart';
import 'package:flutter_note_app/pages/notes_page.dart';
import 'package:flutter_note_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // initializing the note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        //Note provider
        ChangeNotifierProvider(
          create: (context) => NoteDatabase(),
        ),

        //Theme provider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
