import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/widgets/button/app_gradient_button.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget(
      {Key? key,
      this.message,
      this.isComingSoon = false,
      this.showButton = false})
      : super(key: key);
  final bool isComingSoon, showButton;
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      // color: Colors.red,
      constraints: BoxConstraints(minHeight: size(context).height * 0.5),
      width: size(context).width * 0.8,
      // width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(13, 145, 20, 255),
            Color.fromARGB(45, 146, 79, 255),
          ], begin: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/lottie/noitems.json',
                  height: 220, width: 220)),

          SizedBox(height: 10),
          // isComingSoon
          //     ? SizedBox()
          //     : AppText(message ?? 'No Items',
          //         color: AppColors.orange, textSize: AppTextSize.big),
          SizedBox(height: 10),
          if (!showButton)
            AppGradientButton(
                widthRatio: 0.4,
                buttonText: 'No Items',
                isOval: true,
                onTap: () {})
        ],
      ),
    );
  }
}
