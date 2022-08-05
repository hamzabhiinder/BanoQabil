import 'package:banoqabil/pages/SECTIONS/getusername.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdmitCard extends StatefulWidget {
  const AdmitCard({Key? key}) : super(key: key);

  @override
  State<AdmitCard> createState() => _AdmitCardState();
}

class _AdmitCardState extends State<AdmitCard> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docId = [];

  Future getDocsId() async {
    await FirebaseFirestore.instance.collection('user').get().then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              docId.add(element.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 100,
              child: Image.asset(
                'assets/image/logo1.png',
              ),
            ),
            Container(
              height: 50,
              width: 100,
              child: Image.asset(
                'assets/image/logo2.png',
                height: 50,
                width: 100,
              ),
            ),
          ],
        ),
      ),
       body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocsId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount:1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title:GetUserName(documentid: docId[index]),
                            tileColor: Colors.grey[200],
                          ),
                        );
                      });
                },
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
