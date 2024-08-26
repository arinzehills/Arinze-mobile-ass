import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_assessment/modules/login/data/repository/auth_repository.dart';
import 'package:mobile_assessment/modules/widgets/loading/loading.dart';
import 'package:mobile_assessment/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializingScreen extends StatefulWidget {
  const InitializingScreen({super.key});

  @override
  State<InitializingScreen> createState() => _InitializingScreenState();
}

class _InitializingScreenState extends State<InitializingScreen> {
  late Future _boxLoadFuture;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      navigateToMainScreen();
    });
  }

  Future<void> navigateToMainScreen() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final authRepository = AuthRepository(sharedPreferences);
    var routeTo =
        authRepository.isLoggedIn() ? AppRoutes.initialRoute : AppRoutes.login;
    Navigator.of(context).pushReplacementNamed(routeTo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Loading(),
        Text(
          'Initializing Please wait...',
          style: TextStyle(fontSize: 18),
        )
      ],
    ));
  }
}
