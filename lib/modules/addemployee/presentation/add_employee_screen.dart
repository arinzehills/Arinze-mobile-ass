import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/animations/fade_animation.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/modules/addemployee/presentation/add_employee_viewmodel.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import 'package:mobile_assessment/modules/widgets/button/app_gradient_button.dart';
import 'package:mobile_assessment/modules/widgets/dropdown/custom_drop_down.dart';
import 'package:mobile_assessment/modules/widgets/inputs/app_textfield.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';
import 'package:mobile_assessment/modules/widgets/text/error_text.dart';
import 'package:mobile_assessment/utils/generateUniqueID.dart';
import 'package:provider/provider.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName, _lastName, _designation, _salary, error;
  int _level = 0;
  final List<String> _designations = const [
    'Admin',
    'Tech',
    'Legal',
    'Customer Relations',
    'Human Resouces',
  ];
  final List<String> _levels = [
    'Level 0',
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5'
  ];

  @override
  Widget build(BuildContext context) {
    final addEmployeeViewModel = Provider.of<AddEmployeeViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const AppText('Add New Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                onSaved: (value) => _firstName = value,
                validator: (val) =>
                    val!.isEmpty ? 'Please input a value' : null,
                hintText: '',
                labelText: 'First Name',
              ),
              CustomTextField(
                onSaved: (value) => _lastName = value,
                validator: (val) =>
                    val!.isEmpty ? 'Please input a value' : null,
                hintText: '',
                labelText: 'Last Name',
              ),
              CustomDropdown(
                defaultText: 'Select Designation',
                items: _designations,
                onSelected: (val) {
                  setState(() => _designation = val);
                },
              ),
              SizedBox(height: 10),
              CustomDropdown(
                defaultText: 'Level 0',
                items: _levels,
                onSelected: (val) {
                  var level = val.split(' ')[1];
                  setState(() => _level = int.parse(level));
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                onSaved: (value) =>
                    _salary = getSalaryForLevel(_level).toString(),
                hintText: 'Salary',
                isDisabled: true,
                labelText: 'Salary N' + getSalaryForLevel(_level).toString(),
              ),
              SizedBox(height: 20),
              if (error != null) ErrorText(error: error!),
              AppGradientButton(
                buttonText: 'Add Employee',
                widthRatio: 0.6,
                isOval: true,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_designation == null) {
                      setState(() => error = "Please Select Disignation");
                      return;
                    }

                    final newEmployee = EmployeeEntity(
                      id: generateUniqueId(),
                      firstName: _firstName!,
                      lastName: _lastName!,
                      designation: _designation!,
                      level: _level,
                      productivityScore: 50.0,
                      currentSalary: getSalaryForLevel(_level).toString(),
                      employmentStatus: 1,
                    );

                    await addEmployeeViewModel.addEmployee(newEmployee);

                    if (addEmployeeViewModel.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: AppColors.danger,
                            content: Text(addEmployeeViewModel.errorMessage!)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: AppColors.success,
                            content: AppText(
                                "Added New Employee ${newEmployee.firstName} ${newEmployee.lastName}")),
                      );
                      Navigator.of(context).pop(); // Go back to HomeScreen
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  int getSalaryForLevel(int level) {
    // Define a map to associate levels with salaries
    const Map<int, int> salaryMap = {
      0: 70000,
      1: 100000,
      2: 120000,
      3: 180000,
      4: 200000,
      5: 250000,
    };

    // Return the salary for the given level or 0 if the level is not in the map
    return salaryMap[level] ?? 0;
  }
}
