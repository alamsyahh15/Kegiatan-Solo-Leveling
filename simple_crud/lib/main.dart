import 'package:flutter/material.dart';
import 'package:simple_crud/ui/home_page.dart';

void main() {
  runApp(Routes());
}

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
