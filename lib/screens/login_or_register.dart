import 'package:flora_cure/components/my_login.dart';
import 'package:flora_cure/components/my_register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  final String userType;
  const LoginOrRegister({super.key, required this.userType});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLogin = true;
  bool showFarmerLogin = true;
  void toggleLoginOrSignUp() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return MySignIn(
        userType: widget.userType,
        onTap: toggleLoginOrSignUp,
      );
    } else {
      return RegisterPage(
        userType: widget.userType,
        onTap: toggleLoginOrSignUp,
      );
    }
  }
}
