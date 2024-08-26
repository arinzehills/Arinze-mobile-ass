// EmployeeViewModel.dart

import 'package:flutter/material.dart';
import 'package:mobile_assessment/modules/addemployee/domains/usecases/add_employee_usecase.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import 'package:mobile_assessment/modules/home/presentation/home_viewmodel.dart';

class AddEmployeeViewmodel extends ChangeNotifier {
  final AddEmployeeUseCase addEmployeeUseCase;
  String? errorMessage;
  final HomeViewModel homeViewModel;

  AddEmployeeViewmodel(this.addEmployeeUseCase, this.homeViewModel);

  Future<void> addEmployee(EmployeeEntity employee) async {
    try {
      await addEmployeeUseCase(employee);
      homeViewModel.onboardEmployee(employee);
      notifyListeners();
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
