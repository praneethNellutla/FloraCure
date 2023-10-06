import 'package:flora_cure/screens/login_or_register.dart';
import 'package:flutter/material.dart';

class ExpertLogin extends StatefulWidget {
  const ExpertLogin({super.key});

  @override
  State<ExpertLogin> createState() => _ExpertLoginState();
}

class _ExpertLoginState extends State<ExpertLogin> {
  @override
  Widget build(BuildContext context) {
    return const LoginOrRegister(
      userType: "Expert",
    );
  }
}
