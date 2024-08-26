// login/data/repositories/auth_repository.dart

import 'dart:convert';

import 'package:mobile_assessment/modules/login/data/models/admin_model.dart';
import 'package:mobile_assessment/modules/login/domain/entities/admin_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_assessment/modules/login/domain/entities/admin_entity.dart';

class AuthRepository {
  final SharedPreferences sharedPreferences;

  AuthRepository(this.sharedPreferences);

  Future<void> saveAdmin(AdminModel admin) async {
    await sharedPreferences.setString('admin', json.encode(admin.toJson()));
    await sharedPreferences.setBool('isLoggedIn', true);
  }

  Future<AdminModel?> getAdmin() async {
    final adminString = sharedPreferences.getString('admin');
    if (adminString != null) {
      print("not null admin");
      print(adminString);
      final adminJson = json.decode(adminString);
      return AdminModel.fromJson(adminJson);
    }
    return null;
  }

  Future<void> logout() async {
    await sharedPreferences.remove('admin');
    await sharedPreferences.setBool('isLoggedIn', false);
  }

  bool isLoggedIn() {
    return sharedPreferences.getBool('isLoggedIn') ?? false;
  }
}
