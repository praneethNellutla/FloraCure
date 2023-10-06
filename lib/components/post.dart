import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora_cure/screens/ai_screen.dart';
import 'package:flora_cure/screens/communication_screen.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String user;
  final String status;
  final Timestamp time;
  final String image;
  final int index;
  const Post(
      {super.key,
      required this.user,
      required this.image,
      required this.status,
      required this.time,
      required this.index});

  Image showImage() {
    return Image.network(
      image,
      width: 200,
      height: 200,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(top: 25, right: 20, left: 20),
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "problem ${index + 1}",
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text("Status : $status"),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AiChat(
                              image: image,
                            )));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]),
                    child: Text(
                      "Ask Dhanvantari",
                      style: TextStyle(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Communication(
                              image: image,
                            )));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]),
                    child: const Text("Expert Solution"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
