import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_assessment/modules/details/presentation/details_screen.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen.dart';
import 'package:mobile_assessment/modules/login/data/repository/auth_repository.dart';
import 'package:mobile_assessment/modules/login/presentation/login_screen.dart';
import 'package:mobile_assessment/modules/widgets/loading/loading.dart';
import 'package:mobile_assessment/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileAssessmentApp extends StatefulWidget {
  final bool isDebug;
  final SharedPreferences sharedPreferences;
  const MobileAssessmentApp(
      {Key? key, this.isDebug = true, required this.sharedPreferences})
      : super(key: key);

  @override
  State<MobileAssessmentApp> createState() => _MobileAssessmentAppState();
}

class _MobileAssessmentAppState extends State<MobileAssessmentApp> {
  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository(widget.sharedPreferences);

    return MaterialApp(
      debugShowCheckedModeBanner: widget.isDebug,
      initialRoute: AppRoutes.initializeScreen,
      onGenerateRoute: AppRoutes.generateRoute,
      // home: const HomeScreen(),
    );
  }
}
