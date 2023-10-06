import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String user;
  final String status;
  final Timestamp time;
  final String image;
  const Post(
      {super.key,
      required this.user,
      required this.image,
      required this.status,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(user),
          Text(status),
          Text(time.toString()),
          Image.network(
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
          )
        ],
      ),
    );
  }
}
