import 'package:mobile_assessment/modules/home/data/models/employee.dart';

import '../entities/employee_entity.dart';
import '../../data/repositories/employee_repository.dart';

class FetchEmployeesUseCase {
  final EmployeeRepository repository;
  FetchEmployeesUseCase(this.repository);

  Future<List<EmployeeEntity>> call() async {
    final models = await repository.fetchEmployees();
    return models
        .map((model) => EmployeeEntity(
              id: model.id,
              firstName: model.firstName,
              lastName: model.lastName,
              level: model.level,
              designation: model.designation,
              productivityScore: model.productivityScore,
              currentSalary: model.currentSalary,
              employmentStatus: model.employmentStatus,
            ))
        .toList();
  }
}
