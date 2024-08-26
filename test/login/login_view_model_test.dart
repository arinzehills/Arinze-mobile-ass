import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assessment/modules/login/domain/entities/admin_entity.dart';
import 'package:mobile_assessment/modules/login/presentation/login_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

import 'login_mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockAuthRepository mockAuthRepository;
  late LoginViewModel loginViewModel;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockLoginUseCase = MockLoginUseCase();
    loginViewModel = LoginViewModel(mockLoginUseCase);
  });
  test('login success', () async {
    final adminModel = AdminEntity(
        id: '1',
        firstName: 'Ac',
        lastName: 'Hills',
        username: 'admin',
        designation: 'Admin',
        email: 'a@a.com');

    loginViewModel.usernameController.text = 'admin';
    loginViewModel.passwordController.text = 'password';

    when(() => mockLoginUseCase.call('admin', 'password'))
        .thenAnswer((_) async => adminModel);
    final result = await loginViewModel.login();

    expect(result, isTrue);
    expect(loginViewModel.isLoading, isFalse);
    expect(loginViewModel.errorMessage, isNull);
  });
  test('login failure with empty fields', () async {
    loginViewModel.usernameController.text = '';
    loginViewModel.passwordController.text = '';

    final result = await loginViewModel.login();

    expect(result, isFalse);
    expect(loginViewModel.isLoading, isFalse);
    expect(
        loginViewModel.errorMessage, "Please enter both username and password");
  });
  test('login failure with invalid credentials', () async {
    loginViewModel.usernameController.text = 'admin';
    loginViewModel.passwordController.text = '123';
    when(() => mockLoginUseCase.call(any(), any()))
        .thenAnswer((_) async => null);

    final result = await loginViewModel.login();

    expect(result, isFalse);
    expect(loginViewModel.isLoading, isFalse);
    expect(loginViewModel.errorMessage, "Invalid username or password");
  });
}
