import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/common/util/date_util.dart';
import 'package:to_do_list/core/local_db/database_module.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';
import 'package:to_do_list/core/local_db/repository/database_task_repository.dart';

class TaskUseCase {
  // Task DataBase Repository
  final Future<DatabaseTaskRepository> taskRepository =
  DatabaseModule().getDatabaseTaskRepository();

  // 전체 할일 조회
  Future<List<Task>> getAllTasks() async {
    final repository = await taskRepository;
    try {
      final taskList = await repository
          .findAllTasks()
          .then((value) => value.map((e) => Task.fromDataBase(e)).toList());
      await Future.delayed(const Duration(milliseconds: 500));
      return taskList;
    } catch (e) {
      throw Exception('할일 조회에 실패했습니다.');
    }
  }

  // 할일 리스트 조회하기
  Future<List<Task>> getPendingTaskList() async {
    final repository = await taskRepository;
    try {
      final taskList = await repository
          .findPendingTasks()
          .then((value) => value.map((e) => Task.fromDataBase(e)).toList());
      await Future.delayed(const Duration(milliseconds: 500));
      return taskList;
    } catch (e) {
      throw Exception('할일 조회에 실패했습니다.');
    }
  }

  // 진행중인 리스트 조회하기
  Future<List<Task>> getOngoingTaskList() async {
    final repository = await taskRepository;
    try {
      final taskList = await repository
          .findOngoingTasks()
          .then((value) => value.map((e) => Task.fromDataBase(e)).toList());
      await Future.delayed(const Duration(milliseconds: 500));
      return taskList;
    } catch (e) {
      throw Exception('할일 조회에 실패했습니다.');
    }
  }

  // 완료된 리스트 조회하기
  Future<List<Task>> getCompletedTaskList() async {
    final repository = await taskRepository;
    try {
      final taskList = await repository
          .findCompletedTasks()
          .then((value) => value.map((e) => Task.fromDataBase(e)).toList());
      await Future.delayed(const Duration(milliseconds: 500));
      return taskList;
    } catch (e) {
      throw Exception('할일 조회에 실패했습니다.');
    }
  }

  // 할일 등록
  Future<int> addTask(Task task) async {
    final repository = await taskRepository;
    try {
      var result = await repository.insertTask(task.toDataBaseEntity()).then((
          value) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return value;
      }).onError((error, stackTrace) {
        throw Exception('할일 등록에 실패했습니다.');
      });
      return result;
    } catch (e) {
      throw Exception('할일 등록에 실패했습니다.');
    }
  }

  // 할일 제거
  Future<void> deleteTask(Task task) async {
    final repository = await taskRepository;
    try {
      await repository.deleteTask(task.toDataBaseEntity()).then((value) {
        print('할일 삭제에 성공했습니다.');
        return value;
      }).onError((error, stackTrace) {
        throw Exception('할일 삭제에 실패했습니다.');
      });
    } catch (e) {
      throw Exception('할일 삭제에 실패했습니다.');
      }
  }

  Future<void> updateTask(Task task) async {
    final repository = await taskRepository;
    try {
      await repository.updateTask(task.toDataBaseEntity()).then((value) async {
        await Future.delayed(const Duration(milliseconds: 500));
        print('할일 수정에 성공했습니다.');
        return value;
      }).onError((error, stackTrace) {
        throw Exception('할일 수정에 실패했습니다.');
      });
    } catch (e) {
      throw Exception('할일 수정에 실패했습니다.');
    }
  }


  // 할일 여러개 제거
  Future<void> deleteTasksFromIndex(int index) async {
    final repository = await taskRepository;
    try {
      await repository.deleteTasksFromIndex(index).then((value) {
        print('할일 삭제에 성공했습니다.');
        return value;
      }).onError((error, stackTrace) {
        throw Exception('할일 삭제에 실패했습니다.');
      });
    } catch (e) {
      throw Exception('할일 삭제에 실패했습니다.');
    }
  }
}
