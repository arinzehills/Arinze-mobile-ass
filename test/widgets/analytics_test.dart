import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/modules/details/presentation/widgets/analytics.dart';

import 'package:mobile_assessment/modules/widgets/text/app_text.dart';

void main() {
  group('Analytics Widget Tests', () {
    testWidgets('Displays the correct name, salary percentage, and new status',
        (WidgetTester tester) async {
      // Arrange
      const name = 'John Doe';
      const salaryChangePercentage = 15.5;
      const newStatus = 'Promoted';

      // Act
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Analytics(
            name: name,
            salaryChangePercentage: salaryChangePercentage,
            newStatus: newStatus,
          ),
        ),
      ));

      // Assert
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('15.50%'), findsOneWidget);
      expect(find.text('Promoted'), findsOneWidget);
    });

    testWidgets(
        'Displays the correct icon and color for a positive salary change',
        (WidgetTester tester) async {
      // Arrange
      const name = 'John Doe';
      const salaryChangePercentage = 15.5;
      const newStatus = 'Promoted';

      // Act
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Analytics(
            name: name,
            salaryChangePercentage: salaryChangePercentage,
            newStatus: newStatus,
          ),
        ),
      ));

      // Assert
      final iconFinder = find.byIcon(Icons.arrow_upward);
      expect(iconFinder, findsOneWidget);

      final appTextFinder = find.byWidgetPredicate((widget) =>
          widget is AppText &&
          widget.text == '15.50%' &&
          widget.color == Colors.green);
      expect(appTextFinder, findsOneWidget);
    });

    testWidgets(
        'Displays the correct icon and color for a negative salary change',
        (WidgetTester tester) async {
      // Arrange
      const name = 'Jane Doe';
      const salaryChangePercentage = -10.0;
      const newStatus = 'Demoted';

      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Analytics(
            name: name,
            salaryChangePercentage: salaryChangePercentage,
            newStatus: newStatus,
          ),
        ),
      ));

      // Assert
      final iconFinder = find.byIcon(Icons.arrow_downward);
      expect(iconFinder, findsOneWidget);

      final appTextFinder = find.byWidgetPredicate((widget) =>
          widget is AppText &&
          widget.text == '10.00%' &&
          widget.color == Colors.red);
      expect(appTextFinder, findsOneWidget);
    });

    testWidgets('Displays the correct icon and color for terminated status',
        (WidgetTester tester) async {
      // Arrange
      const name = 'Jane Doe';
      const salaryChangePercentage = 0.0;
      const newStatus = 'Terminated';

      // Act
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: Analytics(
          name: name,
          salaryChangePercentage: salaryChangePercentage,
          newStatus: newStatus,
        ),
      )));

      // Assert
      final iconFinder = find.byIcon(Icons.dangerous_sharp);
      expect(iconFinder, findsOneWidget);

      final appTextFinder = find.byWidgetPredicate((widget) =>
          widget is AppText &&
          widget.text == '0.00%' &&
          widget.color == Colors.red);
      expect(appTextFinder, findsOneWidget);
    });
  });
}
