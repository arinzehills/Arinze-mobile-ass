import 'package:flutter/material.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen_desktop.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen.dart';
import 'package:mobile_assessment/responsive/responsive_layout.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: HomeScreen(), desktopBody: HomeScreenDesktop());
  }
}
