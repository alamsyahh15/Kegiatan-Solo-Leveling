// To parse this JSON data, do
//
//     final menuKasModel = menuKasModelFromJson(jsonString);

import 'package:flutter/material.dart';

class MenuKasModel {
  MenuKasModel({
    this.nameMenu,
    this.baseColor,
    this.total,
    this.assets,
    this.color,
  });

  String nameMenu;
  Color baseColor;
  String total;
  String assets;
  Color color;
}
