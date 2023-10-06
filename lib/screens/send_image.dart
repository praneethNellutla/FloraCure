import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flora_cure/screens/farmer_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SendImage extends StatefulWidget {
  final File? imageFile;
  final dynamic user;

  SendImage({Key? key, required this.imageFile, required this.user});

  @override
  State<SendImage> createState() => _SendImageState();
}

class _SendImageState extends State<SendImage> {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

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
        print("output 1$_output1");
        print("output 2$_output2");
        print("output 3$_output3");
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e}');
    }
  }

  void uploadImage(BuildContext context) async {
    try {
      if (widget.imageFile != null) {
        Dialogs.showLoadingDialog(context, _keyLoader);
        final FirebaseStorage storage = FirebaseStorage.instance;
        final Reference storageReference =
            storage.ref().child("images").child(widget.imageFile!.path);

        final UploadTask uploadTask =
            storageReference.putFile(widget.imageFile!);

        final TaskSnapshot taskSnapshot = await uploadTask;
        final String downloadURL = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection("messages").add({
          "from_name": widget.user["userName"] as String?,
          "from_id": widget.user["userId"] as String?,
          "status": "Pending",
          "image": downloadURL,
          "time": DateTime.now(),
        });

        sendUrl(downloadURL);

        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FarmerDashBoard(
            user: widget.user,
            index: 1,
          ),
        ));
      }
    } on FirebaseException catch (e) {
      String msg = e.code;
      Navigator.pop(context);
      showErrorMessage(msg, context);
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }

  void showErrorMessage(String msg, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red.shade800,
          title: Text(
            msg,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.teal[700],
            radius: 27,
            child: IconButton(
              icon: const Icon(
                Icons.send,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                uploadImage(context);
              },
            ),
          ),
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(widget.imageFile!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            backgroundColor: Colors.black54,
            children: const <Widget>[
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(
                      'Uploading...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
