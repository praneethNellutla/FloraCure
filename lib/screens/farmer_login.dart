import 'package:flora_cure/screens/login_or_register.dart';
import 'package:flutter/material.dart';

class FarmerLogin extends StatefulWidget {
  const FarmerLogin({super.key});

  @override
  State<FarmerLogin> createState() => _FarmerLoginState();
}

class _FarmerLoginState extends State<FarmerLogin> {
  @override
  Widget build(BuildContext context) {
    return const LoginOrRegister(
      userType: "Farmer",
    );
  }
}
