import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            trailing: Icon(Icons.chevron_right),
            title: const Text('Users'),
            onTap: () {
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            trailing: Icon(Icons.chevron_right),
            title: const Text('Logout'),
            onTap: () {
              // Update the state of the app.
            },
          ),
        ],
      ),
    );
  }
}
