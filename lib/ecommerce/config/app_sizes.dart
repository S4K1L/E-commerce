import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  static const double pagePadding = 20;
  static const double sectionGap = 24;
  static const double itemGap = 12;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusPill = 100;

  static double scaleW(BuildContext context, double w) {
    final width = MediaQuery.of(context).size.width;
    return (w / 375.0) * width;
  }

  static double scaleH(BuildContext context, double h) {
    final height = MediaQuery.of(context).size.height;
    return (h / 812.0) * height;
  }
}
