class EmployeeModel {
  final int id;
  final String firstName;
  final String lastName;
  final int level;
  final String designation;
  final double productivityScore;
  final String currentSalary;
  final int employmentStatus;

  EmployeeModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.level,
    required this.productivityScore,
    required this.currentSalary,
    required this.employmentStatus,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      designation: json['designation'],
      level: json['level'],
      productivityScore: json['productivity_score'],
      currentSalary: json['current_salary'],
      employmentStatus: json['employment_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'designation': designation,
      'level': level,
      'productivity_score': productivityScore,
      'current_salary': currentSalary,
      'employment_status': employmentStatus,
    };
  }
}
