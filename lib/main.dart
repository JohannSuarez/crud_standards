import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:crud_standards/screens/user_page.dart';
import 'package:crud_standards/screens/songs_page.dart';

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
      //home: MainPage(),
      //home: UserPage(),
      home: SongsPage(),
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
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final user = User(
        id: docUser.id, name: name, age: 21, birthday: DateTime(2001, 7, 28));

    final json = user.toJson();

    // Create document and write data to Firebase
    await docUser.set(json);
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
}
