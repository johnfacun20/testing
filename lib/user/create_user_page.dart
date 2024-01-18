import 'package:flutter/material.dart';
import 'package:testing/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/api_response.dart';
import '../services/student_services.dart';
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

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    ApiResponse response = await saveUser(_txtname.text, _txtemail.text, _txtage.text, _txtaccount_type.text, _txtpassword.text, token);

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

  List<String> students = [];
  String dropdownValue = "";

  Future<void> getStudents() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    ApiResponse response = await getAllStudents(token);

    if(response.error == null){
      setState(() {
        students = response.data as List<String>;
        dropdownValue = students.first;
      });
    } else {
      print('${response.error}');
    }

  }

  @override
  void initState() {
    getStudents();
    super.initState();
  }

  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

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
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: students.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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

