import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  List rgb;
  ColorContainer(this.rgb);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1.0),
      ),
      width: 40,
      height: 40,
    );
  }
}
