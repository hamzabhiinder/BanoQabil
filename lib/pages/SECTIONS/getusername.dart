import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentid;

  const GetUserName({required this.documentid});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("user");
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentid).get(), 
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return Text('First Name : ${data['first name']}');
      } else {
        return Text('Loading');
      }
    }));
  }
}
