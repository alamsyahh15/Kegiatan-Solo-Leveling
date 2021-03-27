import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ma_laundry/ui/config/colors.dart';
import 'package:ma_laundry/ui/main/home_screen/splashscreen.dart';
import 'package:permission_handler/permission_handler.dart';

void main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  env = env ?? "dev";
  await GlobalConfiguration().loadFromPath("assets/config/$env.json");
  print("Base Url : ${GlobalConfiguration().get("rootUrl")}");
  checkPermission();
  runApp(Routes());
}

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Color(0xFFECF0F5),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: whiteNeutral),
            centerTitle: true,
            textTheme: TextTheme(
                // ignore: deprecated_member_use
                title: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: whiteNeutral)),
            actionsIconTheme: IconThemeData(color: whiteNeutral)),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

Future checkPermission() async {
  // You can request multiple permissions at once.
  Map<Permission, PermissionStatus> status = await [
    Permission.location,
    Permission.storage,
    Permission.camera,
    Permission.location,
    Permission.notification,
    Permission.mediaLibrary
  ].request();
  return status[[Permission.mediaLibrary]];
}
