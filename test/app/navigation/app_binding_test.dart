import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_list/app/data/usecase/task_usecase.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';
import 'package:to_do_list/app/navigation/app_binding.dart';
import 'package:to_do_list/core/local_db/database_module.dart';
import 'package:to_do_list/core/local_db/repository/database_task_repository.dart';

class MockTaskUseCase extends Mock implements TaskUseCase {}

class MockDatabaseModule extends Mock implements DatabaseModule {
  @override
  Future<DatabaseTaskRepository> getDatabaseTaskRepository() async {
    return MockDatabaseTaskRepository();
  }
}

class MockDatabaseTaskRepository extends Mock implements DatabaseTaskRepository {}

void main() {
  group('AppBinding', () {
    setUp(() {
      // Clear GetX dependency injection before each test
      Get.reset();
    });

    test('TaskController is correctly bound', () async {
      // Arrange
      final mockDatabaseModule = MockDatabaseModule();

      Get.put<DatabaseModule>(mockDatabaseModule);

      // Act
      AppBinding().dependencies();

      // Assert
      expect(Get.find<TaskController>(), isA<TaskController>());
    });
  });
}
