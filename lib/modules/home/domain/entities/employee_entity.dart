class EmployeeEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String designation;
  final int level;
  final double productivityScore;
  final String currentSalary;
  final int employmentStatus;

  EmployeeEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.level,
    required this.productivityScore,
    required this.currentSalary,
    required this.employmentStatus,
  });
}
