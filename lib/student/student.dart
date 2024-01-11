import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/services/student_services.dart';

import '../model/api_response.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:StudentPageBody()
    );
  }
}

class StudentPageBody extends StatefulWidget {
  const StudentPageBody({super.key});

  @override
  State<StudentPageBody> createState() => _StudentPageBodyState();
}

class _StudentPageBodyState extends State<StudentPageBody> {

  List<dynamic> students = [];

  Future<void> getStudents() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    ApiResponse response = await getAllStudents(token);

    if(response.error == null){
      setState(() {
        students = response.data as List<dynamic>;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student'),
      ),
      body: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index){

            Map student = students[index] as Map;
            return ListTile(
              title: Text(student['name']),
            );
          }
      ),
    );
  }
}

