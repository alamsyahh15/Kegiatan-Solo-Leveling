import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle sansPro(
        {Color color,
        double fontSize,
        FontWeight fontWeight,
        double letterSpacing,
        double wordSpacing}) =>
    GoogleFonts.sourceSansPro(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
    );
