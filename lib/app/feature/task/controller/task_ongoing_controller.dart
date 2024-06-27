import 'package:get/get.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';

class TaskOngoingController extends GetxController {
  final TaskController _taskController = Get.find<TaskController>();

  List<Task> get ongoingTaskList => _taskController.ongoingTaskList;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    isLoading.value = true;
    await _taskController.getTaskList(TaskStatus.ongoing).catchError((error) {
      print('진행중인 일 조회에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void insertTask(Task task, int position) async {
    isLoading.value = true;
    await _taskController
        .insertTask(ongoingTaskList, task, position)
        .catchError((error) {
      print('진행중인 일 등록에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void completeTask(Task task) async {
    isLoading.value = true;
    await _taskController
        .updateTaskStatus(task, TaskStatus.completed)
        .catchError((error) {
      print('진행중인 일 완료에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void deleteTask(Task task) async {
    isLoading.value = true;
    await _taskController.deleteTask(ongoingTaskList, task).catchError((error) {
      print('진행중인 일 삭제에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void changeTaskPosition(int oldIndex, int newIndex) async {
    isLoading.value = true;
    await _taskController.changeTaskPosition(ongoingTaskList, oldIndex, newIndex).catchError((error) {
      print('진행중인 일 순서 변경에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }
}
