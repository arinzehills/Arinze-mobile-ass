import 'package:flutter/material.dart';
import 'package:mobile_assessment/modules/login/data/repository/auth_repository.dart';
import 'package:mobile_assessment/modules/login/presentation/login_viewmodel.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_assessment/modules/login/domain/usecases/login_usecase.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLoginViewModel extends Mock implements LoginViewModel {
  @override
  TextEditingController get usernameController => TextEditingController();

  @override
  TextEditingController get passwordController => TextEditingController();
}
