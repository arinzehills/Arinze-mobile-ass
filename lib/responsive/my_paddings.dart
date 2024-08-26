import 'package:flutter/material.dart';

class MyPaddings {
  static Padding responsivePadding(context, {child, double padding = 5.0}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    return Padding(
      padding: EdgeInsets.all(isTablet ? 180.0 : padding),
      child: child,
    );
  }

  static responsivePaddingHorizontal(context, {child, double padding = 5.0}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 180.0 : padding),
      child: child,
    );
  }
}
