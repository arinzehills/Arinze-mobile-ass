// AddEmployeeUseCase.dart

import 'package:mobile_assessment/modules/addemployee/data/repository/add_employee_repository.dart';
import 'package:mobile_assessment/modules/home/data/models/employee.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';

class AddEmployeeUseCase {
  final AddEmployeeRepository repository;

  AddEmployeeUseCase(this.repository);

  Future<void> call(EmployeeEntity employee) async {
    try {
      await repository.addEmployee(EmployeeModel(
        id: employee.id,
        firstName: employee.firstName,
        lastName: employee.lastName,
        level: employee.level,
        designation: employee.designation,
        productivityScore: employee.productivityScore,
        currentSalary: employee.currentSalary,
        employmentStatus: employee.employmentStatus,
      ));
    } catch (e) {
      throw Exception("Error adding employee: ${e.toString()}");
    }
  }
}
