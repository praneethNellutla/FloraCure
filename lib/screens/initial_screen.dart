import 'package:flora_cure/components/my_button.dart';
import 'package:flora_cure/screens/expert_login.dart';
import 'package:flora_cure/screens/farmer_login.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    super.key,
  });

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
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
                height: 30.0,
              ),
              Text(
                "Flora Cure",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FarmerLogin()));
                  },
                  msg: "Continue as A Farmer"),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ExpertLogin()));
                  },
                  msg: "Continue as An Expert"),
            ],
          ),
        )),
      ),
    );
  }
}
