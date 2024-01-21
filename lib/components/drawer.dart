import 'package:flutter/material.dart';
import 'package:flutter_note_app/components/drawer_tile.dart';
import 'package:flutter_note_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //header sec
          const DrawerHeader(
            child: Icon(Icons.note),
          ),

          //note tile sec
          DrawerTile(
            tile: 'Notes',
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),

          //settings tile sec
          DrawerTile(
            tile: 'Settings',
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
