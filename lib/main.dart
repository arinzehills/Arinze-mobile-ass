import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mobile_assessment/common/db_boxes.dart';
import 'package:mobile_assessment/modules/addemployee/data/repository/add_employee_repository.dart';
import 'package:mobile_assessment/modules/addemployee/domains/usecases/add_employee_usecase.dart';
import 'package:mobile_assessment/modules/addemployee/presentation/add_employee_viewmodel.dart';
import 'package:mobile_assessment/modules/details/data/repositories/employee_detail_repository.dart';
import 'package:mobile_assessment/modules/details/domain/usecases/fetch_employee_usecase.dart';
import 'package:mobile_assessment/modules/details/presentation/employee_detail_viewmodel.dart';
import 'package:mobile_assessment/modules/home/data/repositories/employee_repository.dart';
import 'package:mobile_assessment/modules/home/domain/usecases/fetch_employees_usecase.dart';
import 'package:mobile_assessment/modules/home/presentation/home_viewmodel.dart';
import 'package:mobile_assessment/modules/login/data/repository/auth_repository.dart';
import 'package:mobile_assessment/modules/login/domain/usecases/login_usecase.dart';
import 'package:mobile_assessment/modules/login/presentation/login_viewmodel.dart';
import 'package:mobile_assessment/modules/widgets/drawer/desktop_nav_provider.dart';
import 'package:mobile_assessment/root_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox(DbBoxes.employeesBox);
    final sharedPreferences = await SharedPreferences.getInstance();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(
            LoginUseCase(AuthRepository(sharedPreferences)),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DesktopNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(
            FetchEmployeesUseCase(EmployeeRepository()),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => EmployeeDetailViewModel(
            FetchEmployeeUseCase(EmployeeDetailRepository()),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AddEmployeeViewmodel(
              AddEmployeeUseCase(AddEmployeeRepository()),
              context.read<HomeViewModel>()),
        ),
      ],
      child: MobileAssessmentApp(
        isDebug: true,
        sharedPreferences: sharedPreferences,
      ),
    ));
  }, (exception, stackTrace) async {});
}
