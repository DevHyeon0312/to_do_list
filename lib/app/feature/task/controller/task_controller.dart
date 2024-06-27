import 'dart:async';

import 'package:get/get.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/app/data/usecase/task_usecase.dart';

/// [TaskController] Task 에 관련해서 공통적으로 공유되어야 하는 데이터와 로직을 정의한 클래스
/// * [taskUseCase] TaskUseCase
/// * [pendingTaskList] 대기중인 할일 리스트
/// * [ongoingTaskList] 진행중인 할일 리스트
/// * [completedTaskList] 완료된 할일 리스트
/// * [createNewTask] 할일 등록
/// * [getTaskList] 할일 리스트 조회하기
/// * [insertTask] 할일 리스트에 할일 추가하기
/// * [deleteTask] 할일 리스트에서 할일 제거하기
/// * [updateTask] 할일 수정하기
/// * [updateTaskStatus] 할일 상태 변경하기
/// * [changeTaskPosition] 할일 순서 변경하기
/// * [getPendingTaskList] 대기중인 할일 리스트 조회하기
/// * [getOngoingTaskList] 진행중인 할일 리스트 조회하기
/// * [getCompleteTaskList] 완료된 할일 리스트 조회하기
///
class TaskController extends GetxController {
  final TaskUseCase taskUseCase;

  TaskController({required this.taskUseCase});

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
        return _getCompleteTaskList();
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

  Future<Task> updateTask(TaskStatus? oldTaskStatus, Task task) async {
    return await taskUseCase.updateTask(task).then((_) {
      if (oldTaskStatus == task.status) {
        switch (oldTaskStatus) {
          case TaskStatus.pending:
            var index =
                pendingTaskList.indexWhere((element) => element.id == task.id);
            pendingTaskList[index] = task;
            break;
          case TaskStatus.ongoing:
            var index =
                ongoingTaskList.indexWhere((element) => element.id == task.id);
            ongoingTaskList[index] = task;
            break;
          case TaskStatus.completed:
            var index = completedTaskList
                .indexWhere((element) => element.id == task.id);
            completedTaskList[index] = task;
            break;
          default:
            throw Exception('올바르지 않은 상태입니다.');
        }
      } else {
        switch (oldTaskStatus) {
          case TaskStatus.pending:
            pendingTaskList.removeWhere((element) => element.id == task.id);
            break;
          case TaskStatus.ongoing:
            ongoingTaskList.removeWhere((element) => element.id == task.id);
            break;
          case TaskStatus.completed:
            completedTaskList.removeWhere((element) => element.id == task.id);
            break;
          default:
            throw Exception('올바르지 않은 상태입니다.');
        }
        switch (task.status) {
          case TaskStatus.pending:
            pendingTaskList.add(task);
            break;
          case TaskStatus.ongoing:
            ongoingTaskList.add(task);
            break;
          case TaskStatus.completed:
            completedTaskList.add(task);
            break;
          default:
            throw Exception('올바르지 않은 상태입니다.');
        }
      }
      return task;
    }).catchError((error) {
      throw Exception('할일 수정에 실패했습니다.');
    });
  }

  Future<void> updateTaskStatus(Task task, TaskStatus newTaskStatus) async {
    TaskStatus oldTaskStatus = task.status;
    task.status = newTaskStatus;
    task.sortId = DateTime.now().millisecondsSinceEpoch;
    return taskUseCase.updateTask(task).then((value) {
      // pending -> ongoing
      if (oldTaskStatus == TaskStatus.pending &&
          newTaskStatus == TaskStatus.ongoing) {
        // 1. pendingTaskList 에서 해당 task 를 제거
        // 2. ongoingTaskList 에 해당 task 를 추가
        pendingTaskList.removeWhere((element) => element.id == task.id);
        ongoingTaskList.add(task);
      }
      // pending -> completed
      else if (oldTaskStatus == TaskStatus.pending &&
          newTaskStatus == TaskStatus.completed) {
        // 1. pendingTaskList 에서 해당 task 를 제거
        // 2. completedTaskList 에 해당 task 를 추가
        pendingTaskList.removeWhere((element) => element.id == task.id);
        completedTaskList.add(task);
      }
      // ongoing -> pending
      else if (oldTaskStatus == TaskStatus.ongoing &&
          newTaskStatus == TaskStatus.pending) {
        // 1. ongoingTaskList 에서 해당 task 를 제거
        // 2. pendingTaskList 에 해당 task 를 추가
        ongoingTaskList.removeWhere((element) => element.id == task.id);
        pendingTaskList.add(task);
      }
      // ongoing -> completed
      else if (oldTaskStatus == TaskStatus.ongoing &&
          newTaskStatus == TaskStatus.completed) {
        // 1. ongoingTaskList 에서 해당 task 를 제거
        // 2. completedTaskList 에 해당 task 를 추가
        ongoingTaskList.removeWhere((element) => element.id == task.id);
        completedTaskList.add(task);
      }
      // completed -> pending
      else if (oldTaskStatus == TaskStatus.completed &&
          newTaskStatus == TaskStatus.pending) {
        // 1. completedTaskList 에서 해당 task 를 제거
        // 2. pendingTaskList 에 해당 task 를 추가
        completedTaskList.removeWhere((element) => element.id == task.id);
        pendingTaskList.add(task);
      }
      // completed -> ongoing
      else if (oldTaskStatus == TaskStatus.completed &&
          newTaskStatus == TaskStatus.ongoing) {
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

  Future<void> changeTaskPosition(
      List<Task> taskList, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final Task item = taskList[oldIndex];
    item.sortId = _getNewSortId(taskList, oldIndex, newIndex);

    var tempList = List<Task>.from(taskList);
    taskList.removeAt(oldIndex);
    taskList.insert(newIndex, item);

    return await taskUseCase.updateTask(item).catchError((error) {
      taskList.clear();
      taskList.addAll(tempList);
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

  Future<void> _getCompleteTaskList() async {
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
