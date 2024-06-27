import 'package:to_do_list/core/local_db/database/task_database.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';
import 'package:to_do_list/core/local_db/repository/database_task_repository.dart';

class DatabaseTaskRepositoryImpl extends DatabaseTaskRepository {
  final TaskDatabase taskDatabase;

  DatabaseTaskRepositoryImpl({required this.taskDatabase});

  @override
  Future<void> deleteTask(DbTaskEntity task) => taskDatabase.taskDao.deleteTask(task);

  @override
  Future<void> deleteTasksFromIndex(int index) => taskDatabase.taskDao.deleteTasksFromIndex(index);

  @override
  Future<List<DbTaskEntity>> findAllTasks() => taskDatabase.taskDao.findAllTasks();

  @override
  Future<List<DbTaskEntity>> findCompletedTasks() => taskDatabase.taskDao.findCompletedTasks();

  @override
  Future<List<DbTaskEntity>> findOngoingTasks() => taskDatabase.taskDao.findOngoingTasks();

  @override
  Future<List<DbTaskEntity>> findPendingTasks() => taskDatabase.taskDao.findPendingTasks();

  @override
  Future<DbTaskEntity?> findTaskById(int id) => taskDatabase.taskDao.findTaskById(id);

  @override
  Future<int> insertTask(DbTaskEntity task) => taskDatabase.taskDao.insertTask(task);

  @override
  Future<List<int>> insertTasks(List<DbTaskEntity> tasks) => taskDatabase.taskDao.insertTasks(tasks);

  @override
  Future<void> updateTask(DbTaskEntity task) => taskDatabase.taskDao.updateTask(task);

  @override
  Future<void> updateTaskToCompleted(int id) => taskDatabase.taskDao.updateTaskToCompleted(id);

  @override
  Future<void> updateTaskToOngoing(int id) => taskDatabase.taskDao.updateTaskToOngoing(id);

  @override
  Future<void> updateTaskToPending(int id) => taskDatabase.taskDao.updateTaskToPending(id);
}