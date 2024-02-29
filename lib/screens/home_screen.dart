import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
