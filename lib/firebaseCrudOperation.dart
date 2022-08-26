import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyapp/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference _product = //SQL TABLE NAME
      FirebaseFirestore.instance.collection('products');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      nameController.text = documentSnapshot['name'];
      priceController.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = nameController.text;
                      final double? price =
                          double.tryParse(priceController.text);
                      if (price != null) {
                        await _product
                            .doc(documentSnapshot!.id)
                            .update({'name': name, 'price': price});
                        nameController.text = '';
                        priceController.text = '';
                      }
                    },
                    child: Text('Update'))
              ],
            ),
          );
        });
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      nameController.text = documentSnapshot['name'];
      priceController.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = nameController.text;
                      final double? price =
                          double.tryParse(priceController.text);
                      if (price != null) {
                        await _product.add({'name': name, 'price': price});
                        nameController.text = '';
                        priceController.text = '';
                      }
                    },
                    child: Text('Update'))
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _product.doc(productId).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('You Have Succesfully Deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: _product.snapshots(), //Check The Data
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            ///Stream Snapshot is basically Row Check data
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount:
                      streamSnapshot.data!.docs.length, //docs Show That Row

                  itemBuilder: (context, index) {
                    final DocumentSnapshot
                        documentSnapshot = // get all Row data in documentSnapshot
                        streamSnapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        title: Text(documentSnapshot['name']),
                        subtitle: Text(documentSnapshot['price'].toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => _update(documentSnapshot),
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () => _delete(documentSnapshot.id),
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
