import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String title;
  VoidCallback onTap;
  bool loading;
  MyButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.defaultColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  color: AppColors.secondaryColor,
                )
              : Text(
                  title.toString(),
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
      ),
    );
  }
}
