import 'package:mobile_assessment/common/io/data.dart';
import 'package:mobile_assessment/modules/home/data/local_db/employees_hive.dart';
import 'package:mobile_assessment/modules/home/data/models/employee.dart';

class EmployeeRepository {
  final EmployeesHive _employeesHive = EmployeesHive();
  List<EmployeeModel> employees = [];
  Future<List<EmployeeModel>> fetchEmployees() async {
    final response = Api.successResponse;

    if (response['statusCode'] == 200) {
      await Future.delayed(const Duration(seconds: 2));
      List<dynamic> data = response['data'];
      if (_employeesHive.getAllEmployees().isNotEmpty) {
        employees = _employeesHive.getAllEmployees();
      } else {
        employees = data.map((e) => EmployeeModel.fromJson(e)).toList();
        _employeesHive.addAllEmployees(employees);
      }
      return employees;
    } else {
      throw Exception(response['message']);
    }
  }
} 

// class EmployeeRepository {
//   final EmployeesHive _employeesHive = EmployeesHive();
//   Future<List<EmployeeModel>> fetchEmployees() async {
//     final response = Api.successResponse;
//     List<EmployeeModel> employeesFromHive = _employeesHive.getAllEmployees();

//     // if (employeesFromHive.isNotEmpty) return employeesFromHive;
//     if (response['statusCode'] == 200) {
//       await Future.delayed(const Duration(seconds: 1));
//       List<dynamic> data = response['data'];
//       List<EmployeeModel> employees =
//           data.map((e) => EmployeeModel.fromJson(e)).toList();

//       // Save the fetched employees to the Hive database
//       // _employeesHive.addAllEmployees(employees);
//       return employees;
//       // print("_employeesHive.getAllEmployees()");
//       // print(_employeesHive.getAllEmployees());
//       // return _employeesHive.getAllEmployees();
//     } else {
//       throw Exception(response['message']);
//     }
//   }
// }

