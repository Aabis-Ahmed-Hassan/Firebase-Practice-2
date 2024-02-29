import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice_code/components/my_button.dart';
import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:firebase_practice_code/screens/home_screen.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _fbAuth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.defaultColor,
        title: Text(
          'Signup Screen',
          style: TextStyle(color: AppColors.secondaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Email';
                      }
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      prefixIcon: Icon(Icons.password_outlined),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyButton(
                    title: 'Sign Up',
                    loading: loading,
                    onTap: () {
                      setState(() {
                        loading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        _fbAuth
                            .createUserWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passwordController.text.toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils.showToastMessage('User Created Successfully');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }).onError((error, stackTrace) {
                          Utils.showToastMessage(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
