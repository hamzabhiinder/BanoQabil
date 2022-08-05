import 'package:banoqabil/pages/index.dart';
import 'package:banoqabil/pages/login.dart';
import 'package:banoqabil/pages/register.dart';
import 'package:banoqabil/pages/verifyEmail.dart';
import 'package:banoqabil/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        loginroutes: (context) => Login(),
        indexpageroute: (context) => IndexPage(),
        verifyEmailPageroute: (context) => verifyEmail(),
        registerpageroute: (context) => Register(),
      },
    );
  }
}
