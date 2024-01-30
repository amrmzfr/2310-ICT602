[<img src="https://github.com/addff/2310-ICT602/blob/main/M3CS2666A/Team%201%20-%20Solidariti/Lab%20Work%204/image.png?raw=true" width="600" height="300"
/>](https://youtu.be/tCH7mtQrmZQ)

MAIN.DART 

import 'package:create/realtime_db/insert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var DefaultFirebaseOptions;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Real Time Database",
                style: TextStyle(color: Colors.pinkAccent, fontSize: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              allButton("Insert Data", RealtimeDatabaseInsertState()),
              const SizedBox(
                height: 15,
              ),
              //allButton("Display Data", RealtimeDatabaseDisplayState()),
              //const SizedBox(
              //  height: 15,
              //),
              //allButton("Update Data", RealtimeDatabaseUpdateState()),
              //const SizedBox(
              //  height: 15,
              //),
              //allButton("Delete Data", RealtimeDatabaseDeleteState()),
              //const SizedBox(
              //  height: 15,
              //),
            ],
          ),
        ),
      )),
    );
  }

  Widget allButton(String text, var pageName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pageName),
        );
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

INSIDE.DART

// ignore_for_file: unnecessary_new

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeDatabaseInsert extends StatefulWidget {
  const RealtimeDatabaseInsert({super.key});

  @override
  RealtimeDatabaseInsertState createState() => RealtimeDatabaseInsertState();
}

class RealtimeDatabaseInsertState extends State<RealtimeDatabaseInsert> {
  var nameController = new TextEditingController();
  var ageController = new TextEditingController();
  var stateController = new TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Text(
            "Insert Data",
            style: TextStyle(fontSize: 28),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
                labelText: 'Name', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(
                labelText: 'Age', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: stateController,
            decoration: const InputDecoration(
                labelText: 'State', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 50,
          ),
          OutlinedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    ageController.text.isNotEmpty &&
                    stateController.text.isNotEmpty) {
                  insertData(nameController.text, ageController.text,
                      stateController.text);
                }
              },
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 18),
              ))
        ],
      )),
    );
  }

  void insertData(String name, String age, String state) {
    String? key = databaseRef.child("Users").child("ListRegister").push().key;
    databaseRef.child("Users").child("ListRegister").child(key!).set({
      'id': key,
      'name': name,
      'age': age,
      'state': state,
    });
    nameController.clear();
    ageController.clear();
    stateController.clear();
  }
}
