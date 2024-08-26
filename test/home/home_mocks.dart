import 'package:mobile_assessment/modules/home/domain/usecases/fetch_employees_usecase.dart';
import 'package:mobile_assessment/modules/home/presentation/home_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchEmployeesUseCase extends Mock implements FetchEmployeesUseCase {}

class MockHomeViewModel extends Mock implements HomeViewModel {
  @override
  Future<void> loadEmployees() async {
    return Future.value();
  }
}
