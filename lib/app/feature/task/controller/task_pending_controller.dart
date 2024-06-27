import 'package:get/get.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';

class TaskPendingController extends GetxController {
  final TaskController _taskController = Get.find<TaskController>();

  List<Task> get pendingTaskList => _taskController.pendingTaskList;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    isLoading.value = true;
    await _taskController.getTaskList(TaskStatus.pending).catchError((error) {
      print('할일 조회에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void insertTask(Task task, int position) async {
    isLoading.value = true;
    await _taskController
        .insertTask(pendingTaskList, task, position)
        .catchError((error) {
      print('할일 등록에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void addTask(String title, TaskCategory? category, DateTime? dueDate) async {
    isLoading.value = true;
    await _taskController
        .createNewTask(Task.newSimpleTask(title, category, dueDate))
        .catchError((error) {
      print('할일 등록에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void deleteTask(Task task) async {
    isLoading.value = true;
    await _taskController.deleteTask(pendingTaskList, task).catchError((error) {
      print('할일 삭제에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void startTask(Task task) async {
    isLoading.value = true;
    await _taskController
        .updateTaskStatus(task, TaskStatus.ongoing)
        .catchError((error) {
      print('할일 시작에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void changeTaskPosition(int oldIndex, int newIndex) async {
    isLoading.value = true;
    await _taskController
        .changeTaskPosition(pendingTaskList, oldIndex, newIndex)
        .catchError((error) {
      print('할일 순서 변경 실패${error.toString()}');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }
}
