import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice_code/components/my_button.dart';
import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:firebase_practice_code/screens/auth/verify_code.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

class ContinueWithPhone extends StatefulWidget {
  const ContinueWithPhone({super.key});

  @override
  State<ContinueWithPhone> createState() => _ContinueWithPhoneState();
}

class _ContinueWithPhoneState extends State<ContinueWithPhone> {
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
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
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: '+1 234 5678 910',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Phone Number';
                      }
                    },
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  MyButton(
                      title: 'Send Code',
                      onTap: () {
                        setState(() {
                          loading = true;
                        });

                        _fbAuth.verifyPhoneNumber(verificationCompleted: (_) {
                          setState(() {
                            loading = false;
                          });
                        }, verificationFailed: (e) {
                          Utils.showToastMessage(
                            e.toString(),
                          );
                          setState(() {
                            loading = false;
                          });
                        }, codeSent: (String verificationCode, int? token) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyCode(
                                verificationId: verificationCode,
                              ),
                            ),
                          );
                          setState(() {
                            loading = false;
                          });
                        }, codeAutoRetrievalTimeout: (e) {
                          Utils.showToastMessage(e.toString());
                          setState(() {
                            loading = false;
                          });
                        });
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
