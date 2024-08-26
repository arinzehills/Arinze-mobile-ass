import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  Loading({this.isTransparent = false, this.message});
  bool isTransparent;
  String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/lottie/circleloader.json',
                  height: 160, width: 160)),
          // Align(
          //     alignment: Alignment.center,
          //     child: Image.asset('/assets/',
          //         height: 80, width: 80)),
          Align(
            alignment: Alignment(0.1, 0.2),
            child: Text(
              message ?? '',
              // 'Fethcing users exams',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
