import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';

class RowText extends StatelessWidget {
  const RowText(this.name, this.value, {super.key, this.isStatus = false});
  final String name;
  final String value;
  final bool isStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AppText(
              name,
              withPadding: true,
              type: AppTextSize.medium,
            ),
          ),
          isStatus
              ? buildStatus(value)
              : AppText(
                  value,
                  color: Colors.grey[600],
                ),
        ],
      ),
    );
  }

  buildStatus(status) {
    Color textColor = status == 'Promoted'
        ? AppColors.success
        : (status == 'Demoted' || status == "Terminated")
            ? AppColors.danger
            : (status == 'No Change')
                ? Colors.orangeAccent
                : Colors.blueAccent; //reversed
    return Container(
      // height: 5,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
          color: textColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: AppText(
        status,
        color: textColor,
      ),
    );
  }
}
