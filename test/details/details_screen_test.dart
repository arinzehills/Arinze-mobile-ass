import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/modules/details/presentation/details_screen.dart';
import 'package:mobile_assessment/modules/details/presentation/employee_detail_viewmodel.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import 'package:mobile_assessment/modules/widgets/loading/loading.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'details_mocks.dart';

void main() {
  late MockEmployeeDetailViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockEmployeeDetailViewModel();
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<EmployeeDetailViewModel>(
          create: (_) => mockViewModel,
          child: EmployeeDetailScreen(employeeId: 1)),
    );
  }

  testWidgets('should display employee details', (WidgetTester tester) async {
    final employee = EmployeeEntity(
        id: 1,
        firstName: 'Jane',
        lastName: 'Doe',
        designation: 'Legal',
        level: 0,
        productivityScore: 50.0,
        currentSalary: '70000',
        employmentStatus: 1);

    when(() => mockViewModel.isLoading).thenReturn(false);
    when(() => mockViewModel.employee).thenReturn(employee);
    when(() => mockViewModel.errorMessage).thenReturn(null);
    when(() => mockViewModel.calculateSalaryChangePercentage())
        .thenReturn(20.0);
    when(() => mockViewModel.determineNewStatus()).thenReturn('Promoted');
    when(() => mockViewModel.calculateNewSalary()).thenReturn('120000');

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('70000'), findsOneWidget);
  });
}
