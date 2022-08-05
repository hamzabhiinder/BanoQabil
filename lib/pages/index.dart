import 'package:banoqabil/auth1/auth_sevices1.dart';
import 'package:banoqabil/pages/SECTIONS/Admitcard.dart';
import 'package:banoqabil/pages/SECTIONS/prefrence.dart';
import 'package:banoqabil/pages/WidgetTextField.dart';
import 'package:banoqabil/pages/login.dart';
import 'package:banoqabil/utilities/dialog/logout_dialog.dart';

import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final user = AuthService.firebase().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/image/logo1.png',
                height: 50,
                width: 100,
              ),
            ),
            Center(
              child: Container(
                child: Image.asset(
                  'assets/image/logo2.png',
                  height: 50,
                  width: 125,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final shouldlogout = await showLogoutDialog(context);
              if (shouldlogout) {
                await AuthService.firebase().logOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) {
                      return Login();
                    },
                  ),
                );
              } else {}
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) {
                          return Prefrence();
                        },
                      ),
                    );
                  },
                  child: containers(Icon(Icons.settings), "Prefrencces")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (builder) {
                        return AdmitCard();
                      },
                    ));
                  },
                  child: containers(Icon(Icons.person), "Admit Card"))
            ],
          ),
          SizedBox(
            height: 50,
          ),
          containers(Icon(Icons.bookmarks_outlined), "Demo Exam")
        ],
      ),
    );
  }
}
