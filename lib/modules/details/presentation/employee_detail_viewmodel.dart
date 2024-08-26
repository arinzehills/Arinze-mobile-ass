// detail/presentation/employee_detail_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:mobile_assessment/modules/details/domain/usecases/fetch_employee_usecase.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';

class EmployeeDetailViewModel extends ChangeNotifier {
  final FetchEmployeeUseCase fetchEmployeeUseCase;

  EmployeeEntity? employee;
  bool isLoading = false;
  String? errorMessage;

  EmployeeDetailViewModel(this.fetchEmployeeUseCase);

  Future<void> loadEmployee(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      employee = await fetchEmployeeUseCase(id);

      if (employee == null) {
        errorMessage = "Employee not found";
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  String determineNewStatus() {
    if (employee!.productivityScore >= 80) return 'Promoted';
    if (employee!.productivityScore >= 50) return 'No Change';
    if (employee!.productivityScore >= 40)
      return employee!.level == 0 ? 'No Change' : 'Demoted';
    return 'Terminated';
  }

  String calculateNewSalary() {
    final newStatus = determineNewStatus();
    final salaryLevels = [70000, 100000, 120000, 180000, 200000, 250000];

    if (newStatus == 'Promoted' && employee!.level < 5) {
      return salaryLevels[employee!.level + 1].toString();
    } else if (newStatus == 'Demoted' && employee!.level > 0) {
      return salaryLevels[employee!.level - 1].toString();
    }
    return employee!.currentSalary;
  }

  double calculateSalaryChangePercentage() {
    final newSalary = double.parse(calculateNewSalary().replaceAll(',', ''));
    final currentSalary =
        double.parse(employee!.currentSalary.replaceAll(',', ''));
    return ((newSalary - currentSalary) / currentSalary) * 100;
  }
}
