import 'package:flutter/material.dart';

class StudentPageW extends StatelessWidget {
  const StudentPageW({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student'),
        ),
        body: Container(
          child: Text('Welcome student!'),
        ),
      ),
    );
  }
}

