import 'package:banoqabil/pages/login.dart';
import 'package:banoqabil/pages/verifyEmail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth1/auth_exception1.dart';
import '../auth1/auth_sevices1.dart';
import '../utilities/dialog/error_dialog.dart';
import 'WidgetTextField.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //text controller
  final _emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final firstnameConroller = TextEditingController();
  final lastnameConroller = TextEditingController();
  final ageConroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    firstnameConroller.dispose();
    lastnameConroller.dispose();
    ageConroller.dispose();
    super.dispose();
  }

  Future addUserDetail(
      String firstname, String lastname, String age, String Email) async {
    await FirebaseFirestore.instance.collection('user').add({
      'first name': firstname,
      'last name': lastname,
      'age': age,
      'Email': Email,
    });
  }

  bool confirmedPass() {
    if (confirmpasswordcontroller.text.trim() ==
        passwordcontroller.text.trim()) {
      addUserDetail(
        firstnameConroller.text.trim(),
        lastnameConroller.text.trim(),
        ageConroller.text.trim(),
        _emailcontroller.text.trim(),
      );

      return true;
    } else {
      return false;
    }
  }

  // Future signUp() async {
  //   if (confirmedPass()) {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _emailcontroller.text,
  //       password: passwordcontroller.text,
  //     );
  //   } else {}
  // }
  Future signUp() async {
    if (confirmedPass()) {
      email:
      _emailcontroller.text;
      password:
      passwordcontroller.text;
      try {
        await AuthService.firebase().createUser(
          email: _emailcontroller.text,
          password: passwordcontroller.text,
          age: ageConroller.text,
          fname: firstnameConroller.text,
          lname: lastnameConroller.text,
        );
        AuthService.firebase().sendEmailVerification();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) {
              return verifyEmail();
            },
          ),
        );
      } on WeakPasswordAuthException {
        await ShowErrorDialog(context, "Weak Password");
      } on EmailAlreadyInUseAuthException {
        await ShowErrorDialog(context, "Email is already in use");
      } on InvalidEmailAuthException {
        await ShowErrorDialog(context, " invalid- email");
      } on GenericAuthException {
        await ShowErrorDialog(context, "Failed To Registration");
      }
    } else {}
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
                          'Hello There!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register the below with your details',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        //FirstNAme text field

                        textfield('First Name', firstnameConroller),

                        SizedBox(
                          height: 10,
                        ),

                        //lastNAme text field

                        textfield('last Name', lastnameConroller),

                        SizedBox(
                          height: 10,
                        ),

                        //AGe text field
                        textfield('Age', ageConroller),
                        SizedBox(
                          height: 10,
                        ),
                        //email text field

                        textfield('Email', _emailcontroller),
                        SizedBox(
                          height: 10,
                        ),
                        //passsword TExtfield
                        textpasswordfield('Password', passwordcontroller),

                        SizedBox(
                          height: 10,
                        ),
                        //Confirmspasssword TExtfield

                        textpasswordfield(
                            'Confirm Password', confirmpasswordcontroller),
                        SizedBox(
                          height: 10,
                        ),
                        // Sigin buttton
                        GestureDetector(
                          onTap: signUp,
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
                                'Sign Up',
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
                        //I am a member

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I am a member?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Login();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Log In',
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
