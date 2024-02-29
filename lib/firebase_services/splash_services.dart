import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/auth/signup_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupScreen(),
        ),
      );
    });
  }
}
