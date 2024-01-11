import 'package:flutter/material.dart';
import 'package:testing/user/user.dart';

import '../model/api_response.dart';
import '../services/user_services.dart';
import '../styles.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("New User"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: CreateUserPageBody()
    )
    );
  }
}

class CreateUserPageBody extends StatefulWidget {
  const CreateUserPageBody({super.key});

  @override
  State<CreateUserPageBody> createState() => _CreateUserPageBodyState();
}

class _CreateUserPageBodyState extends State<CreateUserPageBody> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _txtname = TextEditingController();
  TextEditingController _txtemail = TextEditingController();
  TextEditingController _txtage = TextEditingController();
  TextEditingController _txtpassword = TextEditingController();
  TextEditingController _txtaccount_type = TextEditingController();

  Future<void> saveRecord()async {

    ApiResponse response = await saveUser(_txtname.text, _txtemail.text, _txtage.text, _txtaccount_type.text, _txtpassword.text);

    if(response.error == null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${response.data}'))
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('${response.error}')
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                Divider(),
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
                          saveRecord();
                        });
                      }
                    },
                  ),
              ],
            ),
    );
  }
}

