import 'package:to_do_list/core/local_db/repository/database_task_repository.dart';
import 'package:to_do_list/core/local_db/repository/database_task_repository_impl.dart';
import 'package:to_do_list/core/local_db/database/task_database.dart';

class DatabaseModule {
  static final DatabaseModule _instance = DatabaseModule._privateConstructor();

  DatabaseModule._privateConstructor();

  factory DatabaseModule() {
    return _instance;
  }

  Future<DatabaseTaskRepository> getDatabaseTaskRepository() async {
    return DatabaseTaskRepositoryImpl(
        taskDatabase: await $FloorTaskDatabase
        .databaseBuilder('task_database.db')
        .build()
    );
  }
}