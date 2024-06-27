import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';

abstract class DatabaseTaskRepository {
  Future<int> insertTask(DbTaskEntity task);

  Future<List<int>> insertTasks(List<DbTaskEntity> tasks);

  Future<void> deleteTask(DbTaskEntity task);

  Future<void> deleteTasksFromIndex(int index);

  Future<void> updateTask(DbTaskEntity task);

  Future<List<DbTaskEntity>> findAllTasks();

  Future<List<DbTaskEntity>> findPendingTasks();

  Future<List<DbTaskEntity>> findOngoingTasks();

  Future<List<DbTaskEntity>> findCompletedTasks();

  Future<DbTaskEntity?> findTaskById(int id);

  Future<void> updateTaskToPending(int id);

  Future<void> updateTaskToOngoing(int id);

  Future<void> updateTaskToCompleted(int id);
}