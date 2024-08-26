import 'package:mobile_assessment/modules/login/data/models/admin_model.dart';
import 'package:mobile_assessment/modules/login/data/repository/auth_repository.dart';
import 'package:mobile_assessment/modules/login/domain/entities/admin_entity.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<AdminEntity?> call(String username, String password) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1)); // Replace with actual API call

    if (username == "admin" && password == "password") {
      // Replace with actual validation
      final admin = AdminModel(
        id: '1',
        firstName: 'Arinze',
        lastName: 'Hills',
        username: username,
        designation: 'Adminstration',
        email: 'admin@xyz-company.com',
      );
      await authRepository.saveAdmin(admin);
      return AdminEntity(
        id: admin.id,
        firstName: admin.firstName,
        lastName: admin.lastName,
        username: admin.username,
        designation: admin.designation,
        email: admin.email,
      );
    } else {
      return null;
    }
  }
}
