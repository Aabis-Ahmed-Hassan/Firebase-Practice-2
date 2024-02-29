import 'dart:async';

import 'package:flutter/material.dart';

import '../add_post.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }
}
