import 'package:flutter/material.dart';
import 'color_container.dart';

class ColorBox extends StatelessWidget {
  List rgb;
  ColorBox(this.rgb);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ColorContainer(rgb[0]),
            ColorContainer(rgb[1]),
            ColorContainer(rgb[2]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ColorContainer(rgb[3]),
            ColorContainer(rgb[4]),
            ColorContainer(rgb[5]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ColorContainer(rgb[6]),
            ColorContainer(rgb[7]),
            ColorContainer(rgb[8]),
          ],
        ),
      ],
    );
  }
}
