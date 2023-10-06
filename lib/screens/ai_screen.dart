import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AiChat extends StatefulWidget {
  final String image;

  const AiChat({super.key, required this.image});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  String _output1 = "";

  String _output2 = "";

  String _output3 = "";

  Future<void> sendUrl(String downloadUrl) async {
    final url = downloadUrl.trim();

    if (url.isEmpty) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.9.2.221:5000/upload'),
        body: {'url': url},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _output1 = data['Plant name'];
          _output2 = data['confident score'];
          _output3 = data['treatment'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e}');
    }
  }

  Image showImage(String image, BuildContext context) {
    sendUrl(widget.image);
    return Image.network(
      image,
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.3,
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
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text("Dhanvantari"),
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
            Container(
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
                      const Text(
                        "Problem",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        _output1,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Confidence",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(_output3, style: const TextStyle(fontSize: 18)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Solution",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(_output2, style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
