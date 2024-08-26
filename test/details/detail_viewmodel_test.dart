import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/modules/details/presentation/employee_detail_viewmodel.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import 'package:mocktail/mocktail.dart';

import 'details_mocks.dart';

void main() {
  late EmployeeDetailViewModel viewModel;
  late MockFetchEmployeeUseCase mockFetchEmployeeUseCase;

  setUp(() {
    mockFetchEmployeeUseCase = MockFetchEmployeeUseCase();
    viewModel = EmployeeDetailViewModel(mockFetchEmployeeUseCase);
  });

  test('should load employee successfully', () async {
    final employee = EmployeeEntity(
        id: 1,
        firstName: 'Jane',
        lastName: 'Doe',
        designation: 'Legal',
        level: 0,
        productivityScore: 50,
        currentSalary: '70000',
        employmentStatus: 1);

    when(() => mockFetchEmployeeUseCase.call(1))
        .thenAnswer((_) async => employee);

    final result = await viewModel.loadEmployee(1);

    expect(viewModel.employee, employee);
    expect(viewModel.isLoading, false);
    expect(viewModel.errorMessage, isNull);
  });
  test('should handle employee not found', () async {
    when(() => mockFetchEmployeeUseCase.call(1)).thenAnswer((_) async => null);

    await viewModel.loadEmployee(1);

    expect(viewModel.employee, isNull);
    expect(viewModel.isLoading, false);
    expect(viewModel.errorMessage, 'Employee not found');
  });
}
