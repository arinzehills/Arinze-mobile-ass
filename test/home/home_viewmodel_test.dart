import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import 'package:mobile_assessment/modules/home/presentation/home_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

import 'home_mocks.dart';

void main() {
  late HomeViewModel viewModel;
  late MockFetchEmployeesUseCase mockFetchEmployeesUseCase;

  setUp(() {
    mockFetchEmployeesUseCase = MockFetchEmployeesUseCase();
    viewModel = HomeViewModel(mockFetchEmployeesUseCase);
  });

  test('loads employees successfully', () async {
    final employees = [
      EmployeeEntity(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          designation: 'Tech',
          level: 0,
          productivityScore: 50,
          currentSalary: '70000',
          employmentStatus: 1)
    ];
    when(() => mockFetchEmployeesUseCase()).thenAnswer((_) async => employees);
    await viewModel.loadEmployees();

    expect(viewModel.employees, equals(employees));
    expect(viewModel.filteredEmployees, equals(employees));
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.errorMessage, isNull);
  });
  test('handles error while loading employees', () async {
    when(() => mockFetchEmployeesUseCase())
        .thenThrow(Exception('Failed to load employees'));

    await viewModel.loadEmployees();

    expect(viewModel.employees, isEmpty);
    expect(viewModel.filteredEmployees, isEmpty);
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.errorMessage, 'Exception: Failed to load employees');
  });
  test('filters employees based on search query', () {
    final employees = [
      EmployeeEntity(
          id: 1,
          firstName: 'Jane',
          lastName: 'Doe',
          designation: 'Tech',
          level: 0,
          productivityScore: 50,
          currentSalary: '70000',
          employmentStatus: 1)
    ];

    viewModel.employees = employees;
    viewModel.filteredEmployees = employees;

    viewModel.filterEmployees('Jane');

    expect(viewModel.filteredEmployees.length, 1);
    expect(viewModel.filteredEmployees[0].firstName, 'Jane');
  });
  test('applies filters correctly', () {
    final employees = [
      EmployeeEntity(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          designation: 'Tech',
          level: 0,
          productivityScore: 50,
          currentSalary: '70000',
          employmentStatus: 1),
      EmployeeEntity(
          id: 1,
          firstName: 'Jane',
          lastName: 'Doe',
          designation: 'Legal',
          level: 0,
          productivityScore: 50,
          currentSalary: '70000',
          employmentStatus: 1)
    ];

    viewModel.employees = employees;
    viewModel.filteredEmployees = employees;

    final filters = {
      'designation': ['Legal'],
    };

    viewModel.applyFilters(filters);

    expect(viewModel.filteredEmployees.length, 1);
    expect(viewModel.filteredEmployees[0].designation, 'Legal');
  });
}
