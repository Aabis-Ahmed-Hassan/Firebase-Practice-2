import 'package:flutter/material.dart';

import '../firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ss = SplashServices();
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
