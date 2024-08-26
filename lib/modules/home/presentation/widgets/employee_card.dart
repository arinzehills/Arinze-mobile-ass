import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/details/presentation/details_screen.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee});
  final EmployeeEntity employee;
  @override
  Widget build(BuildContext context) {
    bool isTablet = size(context).width > 600;
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: isTablet ? 29 : 15),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          radius: isTablet ? 50 : 28,
          backgroundColor: AppColors.lightPurple
              .withOpacity(0.1), // Background color with opacity
          child: Icon(IconlyBold.profile,
              color: AppColors.lightPurple), // Icon color
        ),
        title: Text('${employee.firstName} ${employee.lastName}'),
        subtitle: Text(employee.designation),
        trailing: Column(
          children: [
            SizedBox(height: 10),
            AppText(
              'level',
              type: AppTextSize.big,
            ),
            Text(
              employee.level.toString(),
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EmployeeDetailScreen(employeeId: employee.id),
            ),
          );
        },
      ),
    );
  }
}
