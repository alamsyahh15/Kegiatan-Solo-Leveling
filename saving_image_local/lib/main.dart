import 'package:flutter/material.dart';
import 'package:saving_image_local/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
  requestPermissions();
}

Future requestPermissions() async {
  Map<Permission, PermissionStatus> status = await [
    Permission.location,
    Permission.storage,
    Permission.mediaLibrary
  ].request();
  return status[[Permission.location]];
}
