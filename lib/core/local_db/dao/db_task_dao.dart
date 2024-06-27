import 'package:floor/floor.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';

@dao
abstract class DbTaskDao {
  @insert
  Future<int> insertTask(DbTaskEntity task);

  @insert
  Future<List<int>> insertTasks(List<DbTaskEntity> tasks);

  @delete
  Future<void> deleteTask(DbTaskEntity task);

  @Query('DELETE FROM task_table WHERE id >= :index')
  Future<void> deleteTasksFromIndex(int index);

  @update
  Future<void> updateTask(DbTaskEntity task);

  @Query('SELECT * FROM task_table order by sortId ASC')
  Future<List<DbTaskEntity>> findAllTasks();

  @Query('SELECT * FROM task_table WHERE isOnGoing = 0 AND isCompleted = 0 ORDER BY sortId ASC')
  Future<List<DbTaskEntity>> findPendingTasks();

  @Query('SELECT * FROM task_table WHERE isOnGoing = 1 AND isCompleted = 0 ORDER BY sortId ASC')
  Future<List<DbTaskEntity>> findOngoingTasks();

  @Query('SELECT * FROM task_table WHERE isCompleted = 1 ORDER BY sortId ASC')
  Future<List<DbTaskEntity>> findCompletedTasks();

  @Query('SELECT * FROM task_table WHERE id = :id')
  Future<DbTaskEntity?> findTaskById(int id);

  @Query('UPDATE task_table SET isOnGoing = 0, isCompleted = 0 WHERE id = :id')
  Future<void> updateTaskToPending(int id);

  @Query('UPDATE task_table SET isOnGoing = 1, isCompleted = 0 WHERE id = :id')
  Future<void> updateTaskToOngoing(int id);

  @Query('UPDATE task_table SET isOnGoing = 0, isCompleted = 1 WHERE id = :id')
  Future<void> updateTaskToCompleted(int id);
}