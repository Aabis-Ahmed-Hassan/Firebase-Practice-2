import 'package:firebase_practice_code/firebase_services/splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices ss = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ss.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Splash Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Splash Screen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                ),
              )
            ],
          ),
        ));
  }
}
