import 'package:flutter/material.dart';

Future navigateRemoveUntil(BuildContext context, Widget widget) async {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Future navigateTo(BuildContext context, Widget widget) async {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}
