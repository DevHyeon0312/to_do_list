import 'package:get/get.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';
import 'package:to_do_list/common/util/debug_log.dart';

class TaskCompleteController extends GetxController {
  final TaskController _taskController = Get.find<TaskController>();

  List<Task> get completedTaskList => _taskController.completedTaskList;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    isLoading.value = true;
    await _taskController.getTaskList(TaskStatus.completed).catchError((error) {
      DebugLog.e('완료된 할일 조회에 실패했습니다.', error: error);
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void insertTask(Task task, int position) async {
    isLoading.value = true;
    await _taskController
        .insertTask(completedTaskList, task, position)
        .catchError((error) {
          DebugLog.e('완료된 할일 등록에 실패했습니다.', error: error);
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void deleteTask(Task task) async {
    isLoading.value = true;
    await _taskController
        .deleteTask(completedTaskList, task)
        .catchError((error) {
          DebugLog.e('완료된 할일 삭제에 실패했습니다.', error: error);
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void changeTaskPosition(int oldIndex, int newIndex) async {
    isLoading.value = true;
    await _taskController
        .changeTaskPosition(completedTaskList, oldIndex, newIndex)
        .catchError((error) {
          DebugLog.e('완료된 할일 순서 변경에 실패했습니다.', error: error);
    }).whenComplete(() {
      isLoading.value = false;
    });
  }
}
