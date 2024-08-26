import 'package:mobile_assessment/common/io/data.dart';
import 'package:mobile_assessment/modules/home/data/local_db/employees_hive.dart';
import 'package:mobile_assessment/modules/home/data/models/employee.dart';

class EmployeeDetailRepository {
  final EmployeesHive _employeesHive = EmployeesHive();

  Future<EmployeeModel> fetchEmployee(id) async {
    final response = Api.successResponse;
    if (response['statusCode'] == 200) {
      await Future.delayed(const Duration(seconds: 1));
      //get employee from local cached db instead of network
      return _employeesHive.getEmployee(id)!;
      // List<dynamic> data = response['data'];
      // var employeeData = data.firstWhere((employee) => employee['id'] == id);
      // return EmployeeModel.fromJson(employeeData);
    } else {
      throw Exception(response['message']);
    }
  }
}
