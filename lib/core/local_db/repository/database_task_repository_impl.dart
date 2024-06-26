import 'package:to_do_list/core/local_db/database/task_database.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';
import 'package:to_do_list/core/local_db/repository/database_task_repository.dart';

class DatabaseTaskRepositoryImpl extends DatabaseTaskRepository {
  final TaskDatabase taskDatabase;

  DatabaseTaskRepositoryImpl({required this.taskDatabase});

  @override
  Future<void> deleteTask(DbTaskEntity task) => taskDatabase.taskDao.deleteTask(task);

  @override
  Future<List<DbTaskEntity>> findAllTasks() => taskDatabase.taskDao.findAllTasks();

  @override
  Future<List<DbTaskEntity>> findCompletedTasks() => taskDatabase.taskDao.findCompletedTasks();

  @override
  Future<List<DbTaskEntity>> findOngoingTasks() => taskDatabase.taskDao.findOngoingTasks();

  @override
  Future<DbTaskEntity?> findTaskById(int id) => taskDatabase.taskDao.findTaskById(id);

  @override
  Future<void> insertTask(DbTaskEntity task) => taskDatabase.taskDao.insertTask(task);

  @override
  Future<void> updateTask(DbTaskEntity task) => taskDatabase.taskDao.updateTask(task);

  @override
  Future<void> updateTaskOrder(int oldId, int newId) => taskDatabase.taskDao.updateTaskOrder(oldId, newId);

  @override
  Future<void> updateTaskToCompleted(int id) => taskDatabase.taskDao.updateTaskToCompleted(id);

  @override
  Future<void> updateTaskToInitial(int id) => taskDatabase.taskDao.updateTaskToInitial(id);

  @override
  Future<void> updateTaskToOngoing(int id) => taskDatabase.taskDao.updateTaskToOngoing(id);
}