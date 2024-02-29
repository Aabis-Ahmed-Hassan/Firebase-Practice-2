import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice_code/screens/home_screen.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../components/my_button.dart';
import '../../constants/app_colors.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;

  VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final OTPController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    OTPController.dispose();
  }

  bool loading = false;
  FirebaseAuth _fbAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.defaultColor,
        title: Text(
          'Continue with Phone',
          style: TextStyle(
            color: AppColors.secondaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: OTPController,
                    decoration: InputDecoration(
                      hintText: 'Enter 6 digits OTP. ',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your OTP';
                      }
                    },
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  MyButton(
                      title: 'Verify OTP',
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });

                        final credentials = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: OTPController.text);

                        try {
                          await _fbAuth.signInWithCredential(credentials);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                          setState(() {
                            loading = false;
                          });
                        } catch (e) {
                          Utils.showToastMessage(e.toString());
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      loading: loading),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
