import 'package:flutter/material.dart';
import 'package:oyos_clone/aeoui.dart';
import 'package:oyos_clone/screens/main_dashboard.dart';
import 'package:oyos_clone/splashscreen.dart';

import 'constant/constant.dart';

class Routes {
  Routes() {
    runApp(MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AEO UI',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: <String, WidgetBuilder>{
        Constants.SPLASH_SCREEN: (BuildContext context) =>
            AnimatedSplashScreen(),
        Constants.AEO_UI: (BuildContext context) => AeoUI(),
        Constants.MAIN_DASHBOARD: (context) => MainDashboard(),
      },
      initialRoute: Constants.SPLASH_SCREEN,
    );
  }
}
