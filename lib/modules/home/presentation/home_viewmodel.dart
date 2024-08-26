import 'package:flutter/foundation.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import 'package:mobile_assessment/modules/home/domain/usecases/fetch_employees_usecase.dart';
import 'package:mobile_assessment/utils/generateUniqueID.dart';

class HomeViewModel extends ChangeNotifier {
  final FetchEmployeesUseCase fetchEmployeesUseCase;

  List<EmployeeEntity> employees = [];
  List<EmployeeEntity> filteredEmployees = [];
  bool isLoading = true;
  String? errorMessage;

  HomeViewModel(this.fetchEmployeesUseCase);

  Future<void> loadEmployees() async {
    try {
      employees = await fetchEmployeesUseCase();
      filteredEmployees = employees;
      isLoading = false;
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> onboardEmployee(EmployeeEntity newEmployee) async {
    // employees.add(newEmployee);
    loadEmployees();
    // filteredEmployees = employees; // Update filtered list if necessary
    notifyListeners();
  }

  filterEmployees(String query) {
    filteredEmployees = query.isEmpty
        ? employees
        : employees.where((employee) {
            final fullName =
                '${employee.firstName} ${employee.lastName}'.toLowerCase();
            return fullName.contains(query.toLowerCase()) ||
                employee.designation
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                employee.level.toString() == query;
          }).toList();
    notifyListeners();
  }

  applyFilters(
    // List<EmployeeEntity> employees,
    Map<String, List<String>> filters,
  ) {
    filteredEmployees = employees.where((employee) {
      bool matches = true;

      if (filters.containsKey('name')) {
        final nameQuery = filters['name']?.first ?? '';
        final fullName =
            '${employee.firstName} ${employee.lastName}'.toLowerCase();
        if (!fullName.contains(nameQuery.toLowerCase())) {
          matches = false;
        }
      }

      if (filters.containsKey('level')) {
        final levels = filters['level'] ?? [];
        if (levels.isNotEmpty && !levels.contains(employee.level.toString())) {
          matches = false;
        }
      }

      if (filters.containsKey('designation')) {
        final designations = filters['designation'] ?? [];
        if (designations.isNotEmpty &&
            !designations.contains(employee.designation)) {
          matches = false;
        }
      }

      return matches;
    }).toList();
    notifyListeners();
  }
}
