import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/main.dart';
import 'package:testing/model/api_response.dart';
import 'package:testing/model/user.dart';
import 'package:testing/student/student.dart';
import 'package:testing/user/create_user_page.dart';
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

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = await prefs.getString('token');

    ApiResponse response = await getAllUsers(token);

    if(response.error == null){
      setState(() {
       users = response.data as List<dynamic>;
      });
    } else {
      print('${response.error}');
    }
  }

  Future<void> _refresh() async {
    getUsers();
    _refreshIndicatorKey.currentState?.show();
  }

  Future<void> deleteRecord(int userID) async {

    ApiResponse response = await deleteUser(userID);

    if(response.error == null){
      getUsers();
    } else {
      print('${response.error}');
    }
  }

  void _showMessageBox(BuildContext context, int userID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete this record?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteRecord(userID);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Manage User"),
            actions: [
              IconButton(
                  onPressed: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.remove('token');
                    await prefs.remove('userId');
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyLogin()));
                  },
                  icon: Icon(Icons.logout)
              )
            ],
            /*bottom: const PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Enter your search query',
                    prefixIcon: Icon(Icons.search),
                    border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 5.0),
                )
                  ),
                ),
              ),
            )*/
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index){

                  Map user = users[index] as Map;

                    return ListTile(
                      leading: Text('${index+1}'),
                      title: Text('${user['name']}'),
                      subtitle: Text('${user['email']}'),
                      trailing: PopupMenuButton(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.more_vert, color: Colors.black,),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(child: Text('Edit'), value: 'Edit',),
                          PopupMenuItem(child: Text('Delete'), value: 'Delete',)
                        ],
                        onSelected: (val) {
                          if(val == 'Edit'){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditUser(userID: user['id'])));
                          } else {
                            _showMessageBox(context, user['id']);
                          }
                        },
                      ),
                    );
                  }
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () { 
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateUserPage()));
            },
            child: Icon(Icons.add),
          ),
      ),
    );
  }
}
