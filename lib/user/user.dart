import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/model/api_response.dart';
import 'package:testing/model/user.dart';
import 'package:testing/user/edit_user.dart';

import '../services/user_services.dart';


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

  List<dynamic> users = [];

  Future<void> getUsers() async {

    ApiResponse response = await getAllUsers();

    if(response.error == null){
      setState(() {
       users = response.data as List<dynamic>;
      });
    } else {
      print('${response.error}');
    }
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("User"),
          ),
          body: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index){

                Map user = users[index] as Map;

                  return ListTile(
                    leading: Text('${index+1}'),
                    title: Text('${user['name']}'),
                    subtitle: Text('${user['email']}'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditUser(userID: user['id'])));
                    },
                  );
                }
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {  },
            child: Icon(Icons.add),
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
