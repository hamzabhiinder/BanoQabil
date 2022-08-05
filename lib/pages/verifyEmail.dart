import 'package:banoqabil/auth1/auth_sevices1.dart';
import 'package:banoqabil/pages/login.dart';
import 'package:banoqabil/pages/register.dart';
import 'package:flutter/material.dart';

class verifyEmail extends StatefulWidget {
  const verifyEmail({Key? key}) : super(key: key);

  @override
  State<verifyEmail> createState() => _verifyEmailState();
}

class _verifyEmailState extends State<verifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Verify Email Page'),
        ),
        drawer: Drawer(),
        body: FutureBuilder(
            future: AuthService.firebase().initialize(),
            builder: (context, sanpshot) {
              switch (sanpshot.connectionState) {
                case ConnectionState.done:
                  return Column(
                    children: [
                      const Text("Please Check your Email and Verify !"),
                      const Text(
                          "If you have not recive email First Check Spam Section of Your Email \nplease press below button"),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            await AuthService.firebase().currentUser;
                          },
                          child: Text("VerifyEmail"),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await AuthService.firebase().logOut();

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (builder) {
                              return Login();
                            }),
                          );
                        },
                        child: Text("Restart"),
                      ),
                    ],
                  );

                default:
                  return const Text("Register");
              }
            }));
  }
}
