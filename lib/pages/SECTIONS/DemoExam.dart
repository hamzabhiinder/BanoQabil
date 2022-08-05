import 'package:flutter/material.dart';

class DemoExam extends StatefulWidget {
  const DemoExam({ Key? key }) : super(key: key);

  @override
  State<DemoExam> createState() => _DemoExamState();
}

class _DemoExamState extends State<DemoExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text("Admit card")
    );
  }
}