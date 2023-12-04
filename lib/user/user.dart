import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserState();
}

class _UserState extends State<UserPage> {

  String token = '';

  void getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token').toString();
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () {
                Navigator.of(context).pop();
            },
            ),
            title: const Text("User"),
          ),
          body: Container(
            child: Text(token),
          ),
      ),
    );
  }
}
