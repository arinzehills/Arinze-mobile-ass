import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/modules/home/domain/entities/employee_entity.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen.dart';
import 'package:mobile_assessment/modules/home/presentation/home_viewmodel.dart';
import 'package:mobile_assessment/modules/home/presentation/widgets/employee_card.dart';
import 'package:mobile_assessment/modules/widgets/inputs/app_textfield.dart';
import 'package:mobile_assessment/modules/widgets/loading/loading.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'home_mocks.dart';

void main() {
  late MockHomeViewModel mockHomeViewModel;

  setUp(() {
    mockHomeViewModel = MockHomeViewModel();
  });

  testWidgets('HomeScreen displays employees and handles search',
      (WidgetTester tester) async {
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

    when(() => mockHomeViewModel.isLoading).thenReturn(false);
    when(() => mockHomeViewModel.errorMessage).thenReturn(null);
    when(() => mockHomeViewModel.filteredEmployees).thenReturn(employees);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<HomeViewModel>.value(
          value: mockHomeViewModel,
          child: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Employee List'), findsOneWidget);
    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.byType(EmployeeCard), findsNWidgets(2));

    // Perform search
    when(() => mockHomeViewModel.filteredEmployees).thenReturn([employees[1]]);
    await tester.enterText(find.byType(CustomTextField), 'Jane');
    await tester.pump();

    expect(find.text('Jane Doe'), findsOneWidget);
  });
  testWidgets('HomeScreen shows loading indicator while loading',
      (WidgetTester tester) async {
    when(() => mockHomeViewModel.isLoading).thenReturn(true);
    when(() => mockHomeViewModel.errorMessage).thenReturn(null);
    when(() => mockHomeViewModel.filteredEmployees).thenReturn([]);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<HomeViewModel>.value(
          value: mockHomeViewModel,
          child: HomeScreen(),
        ),
      ),
    );

    await tester.pump();

    // Verify loading indicator
    expect(find.byType(Loading), findsOneWidget);
  });

  testWidgets('HomeScreen displays error message', (WidgetTester tester) async {
    when(() => mockHomeViewModel.isLoading).thenReturn(false);
    when(() => mockHomeViewModel.errorMessage)
        .thenReturn('Error loading employees');
    when(() => mockHomeViewModel.filteredEmployees).thenReturn([]);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<HomeViewModel>.value(
          value: mockHomeViewModel,
          child: HomeScreen(),
        ),
      ),
    );

    await tester.pump();

    // Verify error message
    expect(find.text('Error loading employees'), findsOneWidget);
  });
}
