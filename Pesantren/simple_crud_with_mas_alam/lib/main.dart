import 'package:flutter/material.dart';
import 'package:simple_crud_with_mas_alam/ui/home_page.dart';

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
