import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/modules/home/presentation/widgets/employee_filter_widget.dart';

void main() {
  testWidgets(
      'EmployeeFilterWidget displays filter options and interacts correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmployeeFilterWidget(
            onApplyFilter: (filters) {},
          ),
        ),
      ),
    );

    // // Verify that the filter button is displayed
    expect(find.byIcon(Icons.filter_list), findsOneWidget);

    // // Tap the filter button to open the filter modal
    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pumpAndSettle();

    // // Verify that the filter options are displayed
    expect(find.text('Filter By'), findsOneWidget);
    expect(find.text('By Name'), findsOneWidget);
    expect(find.text('By Level'), findsOneWidget);
    expect(find.text('By Designation'), findsOneWidget);

    // // Test expanding and interacting with the level dropdown
    await tester.tap(find.text('By Level'));
    final byLevelFinder = find.text('By Level');
    await tester.ensureVisible(byLevelFinder);
    await tester.tap(byLevelFinder);

    await tester.pumpAndSettle();

    // // Test expanding and interacting with the designation dropdown
    final byDesignationFinder = find.text('By Designation');
    await tester.ensureVisible(byDesignationFinder);
    await tester.tap(byDesignationFinder);

    await tester.pumpAndSettle();
    expect(find.text('Customer Relations'), findsOneWidget);
    expect(find.text('Tech'), findsOneWidget);

    // Test entering a name in the text field
    await tester.tap(find.text('By Name'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Jonathan');
    expect(find.text('Jonathan'), findsOneWidget);

    // // Close the modal
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  });
}
