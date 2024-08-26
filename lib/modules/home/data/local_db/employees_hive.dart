import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_assessment/common/db_boxes.dart';
import 'package:mobile_assessment/modules/home/data/models/employee.dart';

class EmployeesHive {
  final _box = Hive.box(DbBoxes.employeesBox);

  addAllEmployees(List<EmployeeModel> employees) {
    try {
      for (var employee in employees) {
        _box.put(employee.id, employee.toJson());
      }
    } catch (e) {
      print("ERROR adding all employees");
      print(e);
    }
  }

  addEmployee(EmployeeModel employee) {
    // clearAllEmployees();
    // return;
    try {
      _box.put(employee.id, employee.toJson());
    } catch (e) {
      print("EROR adding employee");
      print(e);
    }
  }

  EmployeeModel? getEmployee(int id) {
    var employeeBox = _box.get(id);
    var employee =
        EmployeeModel.fromJson(Map<String, dynamic>.from(employeeBox));
    return employee;
  }

  List<EmployeeModel> getAllEmployees() {
    var data = _box.values.toList();
    print("data");
    try {
      List<EmployeeModel> employees = data
          .map(
              (data) => EmployeeModel.fromJson(Map<String, dynamic>.from(data)))
          .toList();
      return employees;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> clearAllEmployees() async {
    try {
      await _box.clear();
      print("All employees have been cleared from the database.");
    } catch (e) {
      print("ERROR clearing employees");
      print(e);
    }
  }
}
