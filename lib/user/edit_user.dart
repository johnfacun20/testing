import 'package:flutter/material.dart';

import '../model/api_response.dart';
import '../services/user_services.dart';
import '../styles.dart';

class EditUser extends StatelessWidget {
  
  const EditUser({super.key, required this.userID});
  final int userID;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _txtname = TextEditingController();
  TextEditingController _txtemail = TextEditingController();
  TextEditingController _txtage = TextEditingController();
  TextEditingController _txtpassword = TextEditingController();
  TextEditingController _txtaccount_type = TextEditingController();

  Future<void> getUsers(int userID) async {

    ApiResponse response = await getUser(userID.toString());

    if(response.error == null){
      setState(() {
       Map user = response.data as Map;

       setState(() {
         _txtname.text = user['name'];
         _txtemail.text = user['email'];
         _txtage.text = user['age'].toString();
         _txtaccount_type.text = user['account_type'].toString();
         _txtpassword.text = user['password'];
       });

      });
    } else {
      print('${response.error}');
    }
  }

  @override
  void initState() {
    getUsers(userID.toInt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            TextFormField(
              controller: _txtname,
              decoration: textBoxStyle("Enter your name", "Name"),
              validator: (String? value) {
                if(value == null || value.isEmpty){
                  return 'Please enter your name!';
                }
                return null;
              },
            ),
            const Divider(),
            TextFormField(
              controller: _txtemail,
              decoration: textBoxStyle("Enter your email", "Email"),
              validator: (String? value) {
                if(value == null || value.isEmpty){
                  return 'Please enter your email!';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _txtage,
              decoration: textBoxStyle("Enter your age", "Age"),
              validator: (String? value) {
                if(value == null || value.isEmpty){
                  return 'Please enter your age!';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _txtaccount_type,
              decoration: textBoxStyle("Enter your account type", "Account Type"),
              validator: (String? value) {
                if(value == null || value.isEmpty){
                  return 'Please enter your account type!';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _txtpassword,
              obscureText: true,
              decoration: textBoxStyle("Enter your password", "Password"),
              validator: (String? value) {
                if(value == null || value.isEmpty){
                  return 'Please enter your password!';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                  padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical: 10, horizontal: 10))
              ),
              child: const Text('Submit', style: TextStyle(color: Colors.white),),
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  setState(() {
                   // saveRecord();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}



