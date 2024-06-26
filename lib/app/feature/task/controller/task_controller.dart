import 'package:get/get.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;

  //TODO : 전체 할일 조회
  void getMockTaskList() async {
await Future.delayed(const Duration(seconds: 1));
    taskList.addAll([
      Task(
        id: 1,
        title: '할일1',
        content: '할일1 내용',
        dueDate: DateTime.now(),
        category: TaskCategory.work,
        link: 'https://naver.com',
        status: TaskStatus.pending,
      ),
      Task(
        id: 2,
        title: '할일2',
        content: '할일2 내용',
        dueDate: DateTime.now(),
        category: TaskCategory.wishlist,
        link: 'https://naver.com',
        status: TaskStatus.pending,
      ),
      Task(
        id: 3,
        title: '할일3',
        content: '할일3 내용',
        dueDate: DateTime.now(),
        category: TaskCategory.personal,
        link: 'https://naver.com',
        status: TaskStatus.pending,
      ),
    ]);
  }

  // 진행중인 할일 조회
  List<Task> getActiveTasks() {
    return taskList.where((task) => task.status == TaskStatus.pending).toList();
  }

  // 완료된 할일 조회
  List<Task> getCompletedTasks() {
    return taskList.where((task) => task.status == TaskStatus.completed).toList();
  }

  // 할일 등록
  void addTask(Task task) {
    taskList.add(task);
  }

  // 할일 수정
  void updateTask(int id, Task updatedTask) {
    int index = taskList.indexWhere((task) => task.id == id);
    if (index != -1) {
      taskList[index] = updatedTask;
    }
  }

  // 할일 삭제
  void deleteTask(int id) {
    taskList.removeWhere((task) => task.id == id);
  }


}