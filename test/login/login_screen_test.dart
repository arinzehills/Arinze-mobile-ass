import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/modules/login/presentation/login_screen.dart';
import 'package:mobile_assessment/modules/login/presentation/login_viewmodel.dart';
import 'package:mobile_assessment/modules/widgets/button/app_gradient_button.dart';
import 'package:mobile_assessment/modules/widgets/inputs/app_textfield.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'login_mocks.dart';

void main() {
  late MockLoginViewModel mockLoginViewModel;

  setUp(() {
    mockLoginViewModel = MockLoginViewModel();
  });

  testWidgets('LoginScreen displays login form and handles login',
      (WidgetTester tester) async {
    when(() => mockLoginViewModel.isLoading).thenReturn(false);
    when(() => mockLoginViewModel.errorMessage).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<LoginViewModel>.value(
          value: mockLoginViewModel,
          child: LoginScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Admin Login'), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.byType(AppGradientButton), findsOneWidget);

    await tester.enterText(find.byType(CustomTextField).at(0), 'admin');
    await tester.enterText(find.byType(CustomTextField).at(1), 'password');

    when(() => mockLoginViewModel.login()).thenAnswer((_) async => true);

    final buttonFinder = find.byType(AppGradientButton);
    await tester.ensureVisible(buttonFinder);
    await tester.tap(find.byType(AppGradientButton));

    verify(() => mockLoginViewModel.login()).called(1);

    // // Check if a Snackbar appears on login failure
    when(() => mockLoginViewModel.login()).thenAnswer((_) async => false);
    when(() => mockLoginViewModel.errorMessage).thenReturn('Login failed');
    await tester.ensureVisible(buttonFinder);
  });
}
