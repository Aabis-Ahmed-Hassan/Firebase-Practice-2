import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice_code/screens/auth/login_screen.dart';
import 'package:firebase_practice_code/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    //user is not logged in
    if (user != null) {
      Timer(
        Duration(seconds: 2),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
      );
    } else {
      Timer(
        Duration(seconds: 2),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
      );
    }
  }
}
