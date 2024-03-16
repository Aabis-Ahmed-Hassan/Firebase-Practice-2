import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice_code/components/my_button.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  bool loading = false;

  final resetPassword = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Forget Password',
          ),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyButton(
                title: 'Reset Password',
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  resetPassword
                      .sendPasswordResetEmail(
                    // email: emailController.text.toString(),
                    email: emailController.text.toString(),
                  )
                      .then((value) {
                    Utils.showToastMessage('Sent');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils.showToastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                },
                loading: loading,
              ),
            ],
          ),
        ));
  }
}
