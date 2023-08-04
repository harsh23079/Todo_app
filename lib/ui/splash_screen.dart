import 'package:flutter/material.dart';
import 'package:todo/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 260,
          ),
          Image.asset('assets/icon/list.png', scale: 3.5),
          SizedBox(
            height: 16,
          ),
          Text(
            "Welcome & Make A List...!!",
            style: TextStyle(fontSize: 20),
          )
        ],
      )),
    );
  }
}
