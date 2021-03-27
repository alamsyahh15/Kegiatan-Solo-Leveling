import 'package:flutter/material.dart';
import 'package:ma_laundry/utils/session_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  void onLoading() async {
    Future.delayed((Duration(seconds: 5)), () {
      sessionManager.checkSession(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoading();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 5));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.easeInOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    this.animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45.withOpacity(0.5),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(
                'https://si.malaundry.co.id/logo/20210226154348/logo.png',
                width: animation.value * 250,
                height: animation.value * 250,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/logo_splash.png',
                    width: animation.value * 250,
                    height: animation.value * 250,
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
