// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_if_null_operators, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Custom/TaskCard.dart';
import 'package:todoapp/Service/Auth_Service.dart';
import 'package:todoapp/pages/AddDoPage.dart';
import 'package:todoapp/pages/SignInPage.dart';
import 'package:todoapp/pages/view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Task").snapshots();
  List<Select> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(221, 8, 26, 45),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(221, 8, 26, 45),
        title: Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.png"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    Text(
                      "Plan Better, Live Better",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(221, 47, 177, 206),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => AddDoPage()));
              },
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignInPage()),
                    (route) => false);
              },
              child: Icon(
                Icons.logout,
                size: 32,
                color: Colors.white,
              ),
            ),
            label: 'LogOut',
          )
        ],
      ),
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> document =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  switch (document["category"]) {
                    case "Study":
                      iconData = Icons.book;
                      iconColor = Colors.red;
                      break;
                    case "Food":
                      iconData = Icons.food_bank;
                      iconColor = Colors.cyan.shade600;
                      break;
                    case "Assignment":
                      iconData = Icons.assignment;
                      iconColor = Colors.purple.shade300;
                      break;
                    case "Cocuriculum":
                      iconData = Icons.meeting_room;
                      iconColor = Colors.green.shade400;
                      break;
                    case "Sport":
                      iconData = Icons.sports_handball;
                      iconColor = Colors.orange.shade600;
                      break;
                    default:
                      iconData = Icons.dangerous_outlined;
                      iconColor = Colors.red.shade400;
                  }
                  selected.add(Select(
                      id: snapshot.data!.docs[index].id, checkValue: false));
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => ViewData(
                            document: document,
                            id: snapshot.data!.docs[index].id,
                          ),
                        ),
                      );
                    },
                    child: TaskCard(
                      title: document["title"] == null
                          ? "Hello There"
                          : document["title"],
                      check: selected[index].checkValue,
                      iconBgColor: Colors.white,
                      iconColor: iconColor,
                      iconData: iconData,
                      time: "11 AM",
                      onChange: onChange,
                      index: index,
                    ),
                  );
                });
          }),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}





///for future use
//
 
