import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  FirebaseAuth _fbAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.defaultColor,
        automaticallyImplyLeading: false,
        title: Text(
          'HomeScreen',
          style: TextStyle(color: AppColors.secondaryColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _fbAuth.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }).onError((error, stackTrace) {
                Utils.showToastMessage(
                  error.toString(),
                );
              });
            },
            icon: Icon(
              Icons.logout_outlined,
              color: AppColors.secondaryColor,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.defaultColor,
        child: Icon(
          Icons.add,
          size: 28,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
