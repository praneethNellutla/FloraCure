// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora_cure/auth/auth_services.dart';
import 'package:flora_cure/components/my_button.dart';
import 'package:flora_cure/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  final String userType;
  const RegisterPage({super.key, required this.onTap, required this.userType});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();

  // Sign user in method
  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (passwordController.text == confirmPasswordController.text) {
        var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        String? userEmail = emailController.text;
        String? userName = userNameController.text;
        String? userId = user.user!.uid;

        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          "email": userEmail,
          "userName": userName,
          "userType": widget.userType,
          "userId": userId
        });
        Navigator.pop(context);

        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showErrorMessage("Password must Be equal to Confirm Password");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String msg) {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.userType} Register"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[400],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 30,
              ),
              // logo
              ClipRRect(
                borderRadius: BorderRadius.circular(43.0),
                child: Image.asset(
                  'assets/appIcon.jpg',
                  width: 105.0,
                  height: 105.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // welcome back, you've been missed
              Text(
                "Let's Create an Account For You",
                style: TextStyle(color: Colors.grey[800], fontSize: 18),
              ),

              const SizedBox(
                height: 30,
              ),

              MyTextField(
                controller: userNameController,
                hintText: "UserName",
                obscureText: false,
              ),

              const SizedBox(
                height: 10,
              ),

              //username, password textfield
              MyTextField(
                controller: emailController,
                hintText: "UserName or Email",
                obscureText: false,
              ),

              const SizedBox(
                height: 10,
              ),

              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 10,
              ),

              MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 15,
              ),
              // sign in button

              MyButton(
                onTap: signUserUp,
                msg: "Register",
              ),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[800],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Or Continue with",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // login with google
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => AuthService().signInWithGoogle(),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: Image.asset(
                        "assets/google.png",
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              //not a member register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member?",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login Now",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
