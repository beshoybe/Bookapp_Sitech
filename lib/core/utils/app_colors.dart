import 'package:flutter/material.dart';

class AppColors {
  static Color scaffoldBackGround = Colors.white;
  static Color primary = Colors.white;
  static Color iconColor = Colors.white;
  static Color authorDetailsColor = Color(0xff7B7B7B);
  static Color DescriptionDetialsColor = Color(0xff545454);
  static List<Color> containerColors = const [
    Color(0xffF1FAEC),
    Color(0xffDFFFD3),
    Color(0xffFEF7EC),
    Color(0xffFCD8D5)
  ];

  static Color getContainerColor(int index) {
    return containerColors[index % 4];
  }
}
