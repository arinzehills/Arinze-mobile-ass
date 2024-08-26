import 'package:mobile_assessment/modules/details/domain/usecases/fetch_employee_usecase.dart';
import 'package:mobile_assessment/modules/details/presentation/employee_detail_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

// Mock FetchEmployeeUseCase
class MockFetchEmployeeUseCase extends Mock implements FetchEmployeeUseCase {}

class MockEmployeeDetailViewModel extends Mock
    implements EmployeeDetailViewModel {
  @override
  Future<void> loadEmployee(int id) async {
    return Future.value(); // Ensure this matches the expected return type
  }
}
