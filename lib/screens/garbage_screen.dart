import 'package:firebase_practice_code/screens/auth/forget_password.dart';
import 'package:firebase_practice_code/screens/firestore/firestore_screen.dart';
import 'package:firebase_practice_code/screens/firestore/upload_image.dart';
import 'package:firebase_practice_code/screens/home_screen.dart';
import 'package:flutter/material.dart';

class GarbageScreen extends StatelessWidget {
  const GarbageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          child: Text('Home Screen'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FirestoreScreen(),
              ),
            );
          },
          child: Text('Firestore Screen'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadImageonFirestore(),
              ),
            );
          },
          child: Text('Uplaod Image on Firestore'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgetPassword(),
              ),
            );
          },
          child: Text(
            'Forget Password',
          ),
        ),
      ]),
    ));
  }
}
