import 'package:get/get.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
  }
}