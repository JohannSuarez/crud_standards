import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Flutter App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class _MainPageState extends State<MainPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
          appBar: AppBar(title: TextField(controller: controller), actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              final name = controller.text;

              createUser(name: name);
            })
      ]));

  Future createUser({required String name}) async {
    // Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');

    final json = {
      'name': name,
      'age': 21,
      'birthday': DateTime(2001, 7, 28),
    };

    // Create document and write data to Firebase
    await docUser.set(json);
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}
