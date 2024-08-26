import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/modules/widgets/loading/loading.dart';

class AppGradientButton extends StatelessWidget {
  String buttonText;
  double? widthRatio;
  double? height;
  bool isOval;
  bool isDisable;
  bool withBorder;
  bool isGradientButton;
  bool reverseChildren;

  bool loadingState;
  List<Color>? gradientColors;
  Color? color;
  Color? textColor;
  final VoidCallback? onTap;
  Widget? child;

  double? fontSize;

  AppGradientButton({
    required this.buttonText,
    this.child,
    this.isOval = false,
    this.withBorder = false,
    this.height,
    this.fontSize,
    this.widthRatio,
    this.isGradientButton = false,
    this.reverseChildren = false,
    this.loadingState = false,
    this.isDisable = false,
    this.gradientColors,
    this.color,
    this.textColor,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: loadingState
            ? null
            : isDisable
                ? null
                : onTap,
        child: Container(
          width: MediaQuery.of(context).size.width *
              (widthRatio ?? 0.9), // Adjust width as needed
          height: height ?? 55, // Adjust height as needed
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDisable || loadingState
                  ? [
                      Color.fromARGB(255, 182, 47, 245).withOpacity(0.7),
                      Color.fromARGB(255, 172, 48, 243).withOpacity(0.5)
                    ]
                  : AppColors.myPurpleGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius:
                BorderRadius.circular(isOval ? 30 : 10), // Circular edges
            boxShadow: [
              BoxShadow(
                color: AppColors.lightPurple.withOpacity(0.4),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: loadingState
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: white,
                      child: Loading(),
                    ),
                  )
                : Text(
                    buttonText ?? 'Text',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
