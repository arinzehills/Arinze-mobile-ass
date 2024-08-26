import 'package:mobile_assessment/modules/home/data/repositories/employee_repository.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import '../../data/repositories/employee_detail_repository.dart';

class FetchEmployeeUseCase {
  final EmployeeDetailRepository repository;

  FetchEmployeeUseCase(this.repository);

  Future<EmployeeEntity?> call(id) async {
    final employee = await repository.fetchEmployee(id);
    return EmployeeEntity(
      id: employee.id,
      firstName: employee.firstName,
      lastName: employee.lastName,
      level: employee.level,
      designation: employee.designation,
      productivityScore: employee.productivityScore,
      currentSalary: employee.currentSalary,
      employmentStatus: employee.employmentStatus,
    );
  }
}
