import 'package:get/get.dart';
import 'package:to_do_list/app/data/usecase/task_usecase.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';
import 'package:to_do_list/core/local_db/database_module.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      TaskController(
        taskUseCase: TaskUseCase(
          taskRepository: DatabaseModule().getDatabaseTaskRepository()
        ),
      ),
    );
  }
}