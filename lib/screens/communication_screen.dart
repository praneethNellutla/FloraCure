import 'package:flutter/material.dart';

class Communication extends StatefulWidget {
  final String image;
  const Communication({super.key, required this.image});

  @override
  State<Communication> createState() => _CommunicationState();
}

Image showImage(String image, BuildContext context) {
  return Image.network(
    image,
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.5,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

class _CommunicationState extends State<Communication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expert Solution"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                showImage(widget.image, context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
