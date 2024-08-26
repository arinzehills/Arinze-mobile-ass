// login/domain/entities/admin_entity.dart

class AdminModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String designation;
  final String email;

  AdminModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.designation,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'designation': designation,
      'email': email,
    };
  }

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      designation: json['designation'],
      email: json['email'],
    );
  }
}
