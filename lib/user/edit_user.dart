import 'package:flutter/material.dart';

class EditUser extends StatelessWidget {
  
  const EditUser({super.key, required this.userID});
  final int userID;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit User'),
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () {
            Navigator.of(context).pop();
          }
          ),
        ),
        body: EditUserBody(userID: userID),
      ),
    );
  }
}

class EditUserBody extends StatefulWidget {

  const EditUserBody({super.key, required this.userID});
  final int userID;

  @override
  State<EditUserBody> createState() => _EditUserBodyState(userID: userID);
}

class _EditUserBodyState extends State<EditUserBody> {

  _EditUserBodyState({required this.userID});
  final int userID;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${userID}+haha'),
    );
  }
}



