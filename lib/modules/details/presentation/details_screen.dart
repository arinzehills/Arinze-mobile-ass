// detail/presentation/employee_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/details/presentation/employee_detail_viewmodel.dart';
import 'package:mobile_assessment/modules/details/presentation/widgets/analytics.dart';
import 'package:mobile_assessment/modules/widgets/loading/loading.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';
import 'package:mobile_assessment/modules/widgets/text/row_text.dart';
import 'package:mobile_assessment/responsive/my_paddings.dart';
import 'package:provider/provider.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final int employeeId;

  EmployeeDetailScreen({required this.employeeId});

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeDetailViewModel>().loadEmployee(widget.employeeId);
    });
    // context.read<EmployeeDetailViewModel>().loadEmployee(widget.employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Details')),
      body: Consumer<EmployeeDetailViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: Loading());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else if (viewModel.employee == null) {
            return Center(child: Text('Employee not found'));
          } else {
            final employee = viewModel.employee!;
            final salaryChangePercentage =
                viewModel.calculateSalaryChangePercentage();

            final newStatus = viewModel.determineNewStatus();

            return MyPaddings.responsivePadding(
              context,
              padding: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Analytics(
                    name: ' ${employee.firstName} ${employee.lastName}',
                    salaryChangePercentage: salaryChangePercentage,
                    newStatus: newStatus,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: myroundedBoxDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  getColor(salaryChangePercentage, newStatus),
                              child: Icon(
                                IconlyBold.user_2,
                                color: white,
                              )),
                        ),
                        SizedBox(height: 30),
                        RowText('Name',
                            '${employee.firstName} ${employee.lastName}'),
                        RowText('Designation', '${employee.designation}  '),
                        RowText('Level', '${employee.level}  '),
                        RowText('Productivity Score:',
                            '${employee.productivityScore}  '),
                        RowText(
                            'Current Salary:', '${employee.currentSalary}  '),
                        RowText('New Salary:',
                            '${viewModel.calculateNewSalary()}  '),
                        RowText('Employment Status:',
                            '${viewModel.determineNewStatus()}',
                            isStatus: true),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Color getColor(salaryChangePercentage, newStatus) {
    if (salaryChangePercentage > 0) return Colors.green;
    if (salaryChangePercentage < 0 || newStatus == "Terminated")
      return Colors.red;

    return Colors.orangeAccent;
  }
}
