import 'package:flora_cure/screens/chat_screen.dart';
import 'package:flora_cure/screens/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpertDashBoard extends StatefulWidget {
  final user;
  const ExpertDashBoard({super.key, required this.user});

  @override
  State<ExpertDashBoard> createState() => _ExpertDashBoardState();
}

class _ExpertDashBoardState extends State<ExpertDashBoard> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Widget> children = [];
  int currIndex = 0;
  @override
  void initState() {
    super.initState();
    children = [
      ChatScreen(
        user: widget.user,
      ),
      MenuScreen(
        user: widget.user,
      )
    ];
  }

  void signOutUser() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Flora Cure",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          actions: [
            IconButton(onPressed: signOutUser, icon: const Icon(Icons.logout)),
          ]),
      body: Text("Expert"),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: currIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(
              Icons.chat_outlined,
              size: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            label: "Menu",
            icon: Icon(
              Icons.menu,
              size: 30.0,
            ),
          )
        ],
        onTap: (int index) {
          setState(() {
            currIndex = index;
          });
        },
      ),
    );
  }
}
