import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';

class Analytics extends StatelessWidget {
  final String name;
  final double salaryChangePercentage;
  final String newStatus;
  const Analytics(
      {super.key,
      required this.salaryChangePercentage,
      required this.name,
      required this.newStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: myroundedBoxDecoration,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(children: [
        AppText(
          '$name',
          textSize: AppTextSize.xxbig,
          color: Colors.black,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                leading: Icon(
                  getArrowIcon(salaryChangePercentage),
                  color: getColor(salaryChangePercentage),
                ),
                title: AppText(
                  '${salaryChangePercentage.abs().toStringAsFixed(2)}%',
                  bold: true,
                  textSize: AppTextSize.xbig,
                  color: getColor(salaryChangePercentage),
                ),
                subtitle: AppText(
                  '$newStatus',
                  textSize: AppTextSize.small,
                  color: getColor(salaryChangePercentage),
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: salaryChangePercentage.abs() / 100,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  salaryChangePercentage >= 0 ? Colors.green : Colors.red,
                ),
                strokeWidth: 10,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Color getColor(salaryChangePercentage) {
    if (salaryChangePercentage > 0) return Colors.green;
    if (salaryChangePercentage < 0 || newStatus == "Terminated")
      return Colors.red;

    return Colors.orangeAccent;
  }

  IconData getArrowIcon(salaryChangePercentage) {
    if (salaryChangePercentage > 0) return Icons.arrow_upward;
    if (salaryChangePercentage < 0) return Icons.arrow_downward;
    if (newStatus == "Terminated") return Icons.dangerous_sharp;
    return IconlyBold.swap;
  }
}
