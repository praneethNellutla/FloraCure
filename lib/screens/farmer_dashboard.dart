import 'package:flora_cure/screens/chat_screen.dart';
import 'package:flora_cure/screens/home_screen.dart';
import 'package:flora_cure/screens/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FarmerDashBoard extends StatefulWidget {
  final user;
  final int index;
  const FarmerDashBoard({super.key, required this.user, required this.index});

  @override
  State<FarmerDashBoard> createState() => _FarmerDashBoardState();
}

class _FarmerDashBoardState extends State<FarmerDashBoard> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Widget> children = [];

  int currIndex = 0;

  @override
  void initState() {
    super.initState();
    currIndex = widget.index;
    children = [
      HomeScreen(
        user: widget.user,
      ),
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
          backgroundColor: Colors.black,
          title: const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              "Flora Cure",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          actions: [
            IconButton(onPressed: signOutUser, icon: const Icon(Icons.logout)),
          ]),
      body: children[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        fixedColor: Colors.white,
        currentIndex: currIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
              size: 30.0,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(
              Icons.chat_outlined,
              size: 30.0,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: "Menu",
            icon: Icon(
              Icons.menu,
              size: 30.0,
              color: Colors.white,
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
