import 'package:flutter/material.dart';
class PageWidget extends StatelessWidget {
  final Color color;
  PageWidget(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
