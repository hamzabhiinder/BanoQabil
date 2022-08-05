import 'package:banoqabil/pages/index.dart';
import 'package:banoqabil/pages/register.dart';
import 'package:banoqabil/pages/verifyEmail.dart';
import 'package:banoqabil/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth1/auth_exception1.dart';
import '../auth1/auth_sevices1.dart';
import '../utilities/dialog/error_dialog.dart';
import 'WidgetTextField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text controller
  final _emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: _emailcontroller.text,
  //     password: passwordcontroller.text,
  //   );
  // }

  Future signIn() async {
    final email = _emailcontroller.text;
    final password = passwordcontroller.text;

    try {
      await AuthService.firebase().logIn(
        email: email,
        password: password,
      );

      final user = AuthService.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        //user verified
        Navigator.of(context)
            .pushNamedAndRemoveUntil(indexpageroute, (route) => false);
      } else {
        //if user not verified
        Navigator.of(context)
            .pushNamedAndRemoveUntil(verifyEmailPageroute, (route) => false);
      }
    } on UserNotFoundAuthException catch (e) {
      await ShowErrorDialog(
        context,
        "User Not Found",
      );
    } on WrongPasswordAuthException {
      await ShowErrorDialog(
        context,
        "wrong credentials",
      );
    } on GenericAuthException {
      await ShowErrorDialog(
        context,
        "Authentication error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.android,
                          size: 100,
                        ),
                        //Hello Again
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Hello Again!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Welcome back, you\'ve been missed',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),

                        //email text field
                        textfield('Email', _emailcontroller),

                        SizedBox(
                          height: 10,
                        ),
                        //passsword TExtfield
                        textpasswordfield('Password', passwordcontroller),

                        SizedBox(
                          height: 15,
                        ),

                        //Forget Password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {

                                  
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return ForgetPasswordPage();
                                  //     },
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        // Sigin buttton
                        GestureDetector(
                          onTap: signIn,
                          child: Container(
                            padding: EdgeInsets.all(23.0),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 100),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        //not a member

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                            registerpageroute, (route) => false);
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            default:
              return const Text("Register");
          }
        },
      ),
    );
  }
}
