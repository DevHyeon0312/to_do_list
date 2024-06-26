import 'package:to_do_list/core/local_db/database_module.dart';
import 'package:to_do_list/core/local_db/repository/database_task_repository.dart';

class TaskUseCase {
  // Task DataBase Repository
  final Future<DatabaseTaskRepository> taskRepository = DatabaseModule().getDatabaseTaskRepository();

}