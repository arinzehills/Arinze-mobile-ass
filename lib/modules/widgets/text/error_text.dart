import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  String error;
  ErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Text(
      error,
      style: TextStyle(color: Colors.red),
    );
  }
}
