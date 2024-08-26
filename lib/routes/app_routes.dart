import 'package:flutter/material.dart';
import 'package:mobile_assessment/initializing_screen.dart';
import 'package:mobile_assessment/modules/addemployee/presentation/add_employee_screen.dart';
import 'package:mobile_assessment/modules/details/presentation/details_screen.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen.dart';
import 'package:mobile_assessment/modules/home/presentation/responsive_home.dart';
import 'package:mobile_assessment/modules/login/presentation/login_screen.dart';
import 'package:mobile_assessment/modules/login/presentation/profile_screen.dart';

class AppRoutes {
  static const String initializeScreen = '/initialize_screen';
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String admin_profile = '/admin_profile';
  static const String employee_detail = '/employee_detail';
  static const String add_employee = '/add_employee';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initializeScreen:
        return MaterialPageRoute(builder: (_) => const InitializingScreen());
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const ResponsiveHome());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case admin_profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case add_employee:
        return MaterialPageRoute(builder: (_) => AddEmployeeScreen());
      case employee_detail:
        final args =
            settings.arguments as int; // Expecting the employeeId as a String

        return MaterialPageRoute(
            builder: (_) => EmployeeDetailScreen(
                  employeeId: args,
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
