import 'dart:async';

import 'package:get/get.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/app/data/usecase/task_usecase.dart';

class TaskController extends GetxController {
  // UseCase
  final TaskUseCase taskUseCase = TaskUseCase();

  final pendingTaskList = <Task>[].obs;
  final ongoingTaskList = <Task>[].obs;
  final completedTaskList = <Task>[].obs;

  Future<void> createNewTask(Task task) async {
    return await taskUseCase.addTask(task).then((_) {
      pendingTaskList.add(task);
    }).catchError((error, stackTrace) {
      throw Exception(error);
    });
  }

  Future<void> getTaskList(TaskStatus taskStatus) {
    switch (taskStatus) {
      case TaskStatus.pending:
        return _getPendingTaskList();
      case TaskStatus.ongoing:
        return _getOngoingTaskList();
      case TaskStatus.completed:
        return _getCopmletedTaskList();
      default:
        throw Exception('올바르지 않은 상태입니다.');
    }
  }

  Future<void> insertTask(List<Task> taskList, Task task, int position) async {
    return await taskUseCase.addTask(task).then((_) {
      taskList.insert(position, task);
    }).catchError((error, stackTrace) {
      throw Exception(error);
    });
  }

  Future<void> deleteTask(List<Task> taskList, Task task) async {
    return await taskUseCase.deleteTask(task).then((_) {
      taskList.removeWhere((element) => element.id == task.id);
    }).catchError((error, stackTrace) {
      throw Exception(error);
    });
  }

  Future<void> updateTaskStatus(Task task, TaskStatus newTaskStatus) async {
    TaskStatus oldTaskStatus = task.status;
    task.status = newTaskStatus;
    task.sortId = DateTime.now().millisecondsSinceEpoch;
    return taskUseCase.updateTask(task).then((value) {
      // pending -> ongoing
      if (oldTaskStatus == TaskStatus.pending && newTaskStatus == TaskStatus.ongoing) {
        // 1. pendingTaskList 에서 해당 task 를 제거
        // 2. ongoingTaskList 에 해당 task 를 추가
        pendingTaskList.removeWhere((element) => element.id == task.id);
        ongoingTaskList.add(task);
      }
      // pending -> completed
      else if (oldTaskStatus == TaskStatus.pending && newTaskStatus == TaskStatus.completed) {
        // 1. pendingTaskList 에서 해당 task 를 제거
        // 2. completedTaskList 에 해당 task 를 추가
        pendingTaskList.removeWhere((element) => element.id == task.id);
        completedTaskList.add(task);
      }
      // ongoing -> pending
      else if (oldTaskStatus == TaskStatus.ongoing && newTaskStatus == TaskStatus.pending) {
        // 1. ongoingTaskList 에서 해당 task 를 제거
        // 2. pendingTaskList 에 해당 task 를 추가
        ongoingTaskList.removeWhere((element) => element.id == task.id);
        pendingTaskList.add(task);
      }
      // ongoing -> completed
      else if (oldTaskStatus == TaskStatus.ongoing && newTaskStatus == TaskStatus.completed) {
        // 1. ongoingTaskList 에서 해당 task 를 제거
        // 2. completedTaskList 에 해당 task 를 추가
        ongoingTaskList.removeWhere((element) => element.id == task.id);
        completedTaskList.add(task);
      }
      // completed -> pending
      else if (oldTaskStatus == TaskStatus.completed && newTaskStatus == TaskStatus.pending) {
        // 1. completedTaskList 에서 해당 task 를 제거
        // 2. pendingTaskList 에 해당 task 를 추가
        completedTaskList.removeWhere((element) => element.id == task.id);
        pendingTaskList.add(task);
      }
      // completed -> ongoing
      else if (oldTaskStatus == TaskStatus.completed && newTaskStatus == TaskStatus.ongoing) {
        // 1. completedTaskList 에서 해당 task 를 제거
        // 2. ongoingTaskList 에 해당 task 를 추가
        completedTaskList.removeWhere((element) => element.id == task.id);
        ongoingTaskList.add(task);
      } else {
        throw Exception('올바르지 않은 상태 전환입니다.');
      }
    }).catchError((error) {
      throw Exception('할일 상태 변경에 실패했습니다.');
    });
  }

  Future<void> changeTaskPosition(List<Task> taskList, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final Task item = taskList[oldIndex];
    item.sortId = _getNewSortId(taskList, oldIndex, newIndex);

    return await taskUseCase.updateTask(item).then((value) {
      taskList.removeAt(oldIndex);
      taskList.insert(newIndex, item);
    }).catchError((error) {
      throw Exception('할일 순서 변경에 실패했습니다.');
    });
  }

  Future<void> _getPendingTaskList() async {
    pendingTaskList.clear();
    return await taskUseCase.getPendingTaskList().then((value) {
      pendingTaskList.addAll(value);
    }).catchError((error, stackTrace) {
      throw Exception(error);
    });
  }

  Future<void> _getOngoingTaskList() async {
    ongoingTaskList.clear();
    return await taskUseCase.getOngoingTaskList().then((value) {
      ongoingTaskList.addAll(value);
    }).catchError((error, stackTrace) {
      throw Exception(error);
    });
  }

  Future<void> _getCopmletedTaskList() async {
    completedTaskList.clear();
    return await taskUseCase.getCompletedTaskList().then((value) {
      completedTaskList.addAll(value);
    }).catchError((error, stackTrace) {
      throw Exception(error);
    });
  }

  int _getNewSortId(List<Task> taskList, int oldIndex, int newIndex) {
    // oldIndex 가 newIndex 보다 작은 경우 (리스트 아이템을 아래로 이동)
    if (oldIndex < newIndex) {
      // 1. newIndex 가 마지막 인덱스인 경우
      if (newIndex == taskList.length - 1) {
        return DateTime.now().millisecondsSinceEpoch;
      }
      // 2. newIndex 가 중간 인덱스인 경우
      else {
        int nextSortId = taskList[newIndex + 1].sortId;
        int currentSortId = taskList[newIndex].sortId;
        if (nextSortId - currentSortId > 1) {
          return (currentSortId + nextSortId) ~/ 2;
        } else {
          return -1;
        }
      }
    }
    // oldIndex 가 newIndex 보다 큰 경우 (리스트 아이템을 위로 이동)
    else {
      // 1. newIndex 가 첫번째 인덱스인 경우
      if (newIndex == 0) {
        return taskList[0].sortId - 100000;
      }
      // 2. newIndex 가 중간 인덱스인 경우
      else {
        int prevSortId = taskList[newIndex - 1].sortId;
        int currentSortId = taskList[newIndex].sortId;
        if (currentSortId - prevSortId > 1) {
          return (prevSortId + currentSortId) ~/ 2;
        } else {
          return -1;
        }
      }
    }
  }
}
