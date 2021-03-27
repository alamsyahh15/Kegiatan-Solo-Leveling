import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ui/home_page.dart';

void main() {
  return runApp(Routes());
}

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: HomePage(),
    );
  }
}
