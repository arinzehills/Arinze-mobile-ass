// login/presentation/login_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_assessment/modules/login/data/models/admin_model.dart';
import 'package:mobile_assessment/modules/login/domain/entities/admin_entity.dart';
import 'package:mobile_assessment/modules/login/domain/usecases/login_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  LoginViewModel(this.loginUseCase);

  Future<bool> login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      errorMessage = "Please enter both username and password";
      notifyListeners();
      return false;
    }

    isLoading = true;
    notifyListeners();

    final admin = await loginUseCase.call(username, password);

    isLoading = false;
    if (admin != null) {
      notifyListeners();
      return true;
    } else {
      errorMessage = "Invalid username or password";
      notifyListeners();
      return false;
    }
  }

  Future<AdminModel?> getAdmin() async {
    print("Fetching admin details...");
    try {
      var admin = await loginUseCase.authRepository.getAdmin();
      if (admin != null) {
        print("Admin ID: ${admin.id}");
        print("Admin Name: ${admin.firstName} ${admin.lastName}");
      } else {
        print("No admin found.");
      }
      return admin;
    } catch (e) {
      print("Error fetching admin: $e");
      return null;
    }
  }

  logout() async {
    return await loginUseCase.authRepository.logout();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
