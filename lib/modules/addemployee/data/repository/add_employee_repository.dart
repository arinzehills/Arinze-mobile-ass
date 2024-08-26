// EmployeeRepository.dart

import 'package:mobile_assessment/common/io/data.dart';
import 'package:mobile_assessment/modules/home/data/local_db/employees_hive.dart';
import 'package:mobile_assessment/modules/home/data/models/employee.dart';
import 'package:mobile_assessment/modules/home/data/repositories/employee_repository.dart';
import 'package:mobile_assessment/utils/generateUniqueID.dart';

class AddEmployeeRepository extends EmployeeRepository {
  List<EmployeeModel> _employees = []; // Simulated storage

  final EmployeesHive _employeesHive = EmployeesHive();

  final employeeHive = EmployeesHive();
  // Add employee (simulated)
  Future<void> addEmployee(EmployeeModel employee) async {
    _employeesHive.addEmployee(employee);
  }
}

  // Future<void> addEmployee(EmployeeModel newEmployee) async {
  //   final response = Api.successResponse;

  //   // Convert the data list from dynamic to Map<String, Object>
  //   List<Map<String, Object>> employeeData = List<Map<String, Object>>.from(
  //       response['data'].map((item) => Map<String, Object>.from(item)));

  //   // Convert newEmployeeJson to Map<String, Object>
  //   Map<String, Object> newEmployeeJson = newEmployee
  //       .toJson()
  //       .map((key, value) => MapEntry(key, value as Object));

  //   print("newEmployeeJson");
  //   print(newEmployeeJson);
  //   print(employeeData);

  //   // Add the new employee to the list
  //   Api.successResponse['data'].add(newEmployeeJson);

  //   print("Updated employeeData:");
  //   print(employeeData);
  // }