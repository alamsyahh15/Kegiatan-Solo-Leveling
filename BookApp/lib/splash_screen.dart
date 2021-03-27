import 'dart:async';
import 'package:flutter/material.dart';
import 'package:book_app/screens/intro_view.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Container (
      child: Center(
        child: Image.asset("images/splash.jpg"),
      ),
    );
  }
  Future<Timer> startTimer() async {
    return Timer(Duration(seconds: 3), onDone);
  }
  void onDone() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => IntroPage()
    ));
  }
}
