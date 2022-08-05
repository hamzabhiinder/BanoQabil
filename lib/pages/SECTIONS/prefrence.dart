import 'package:flutter/material.dart';

class Prefrence extends StatefulWidget {
  const Prefrence({ Key? key }) : super(key: key);

  @override
  State<Prefrence> createState() => _PrefrenceState();
}

class _PrefrenceState extends State<Prefrence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text("Admit card")
    );
  }
}