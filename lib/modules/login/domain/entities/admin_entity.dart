// login/domain/entities/admin_entity.dart

class AdminEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String designation;
  final String email;

  AdminEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.designation,
    required this.email,
  });
}
