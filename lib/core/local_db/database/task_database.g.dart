// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $TaskDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $TaskDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $TaskDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<TaskDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorTaskDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $TaskDatabaseBuilderContract databaseBuilder(String name) =>
      _$TaskDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $TaskDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$TaskDatabaseBuilder(null);
}

class _$TaskDatabaseBuilder implements $TaskDatabaseBuilderContract {
  _$TaskDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $TaskDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $TaskDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<TaskDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TaskDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TaskDatabase extends TaskDatabase {
  _$TaskDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DbTaskDao? _taskDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `task_table` (`id` INTEGER NOT NULL, `sortId` INTEGER NOT NULL, `title` TEXT NOT NULL, `content` TEXT NOT NULL, `category` TEXT NOT NULL, `dueDateMilliSeconds` INTEGER, `link` TEXT NOT NULL, `isOnGoing` INTEGER NOT NULL, `isCompleted` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DbTaskDao get taskDao {
    return _taskDaoInstance ??= _$DbTaskDao(database, changeListener);
  }
}

class _$DbTaskDao extends DbTaskDao {
  _$DbTaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _dbTaskEntityInsertionAdapter = InsertionAdapter(
            database,
            'task_table',
            (DbTaskEntity item) => <String, Object?>{
                  'id': item.id,
                  'sortId': item.sortId,
                  'title': item.title,
                  'content': item.content,
                  'category': item.category,
                  'dueDateMilliSeconds': item.dueDateMilliSeconds,
                  'link': item.link,
                  'isOnGoing': item.isOnGoing ? 1 : 0,
                  'isCompleted': item.isCompleted ? 1 : 0
                }),
        _dbTaskEntityUpdateAdapter = UpdateAdapter(
            database,
            'task_table',
            ['id'],
            (DbTaskEntity item) => <String, Object?>{
                  'id': item.id,
                  'sortId': item.sortId,
                  'title': item.title,
                  'content': item.content,
                  'category': item.category,
                  'dueDateMilliSeconds': item.dueDateMilliSeconds,
                  'link': item.link,
                  'isOnGoing': item.isOnGoing ? 1 : 0,
                  'isCompleted': item.isCompleted ? 1 : 0
                }),
        _dbTaskEntityDeletionAdapter = DeletionAdapter(
            database,
            'task_table',
            ['id'],
            (DbTaskEntity item) => <String, Object?>{
                  'id': item.id,
                  'sortId': item.sortId,
                  'title': item.title,
                  'content': item.content,
                  'category': item.category,
                  'dueDateMilliSeconds': item.dueDateMilliSeconds,
                  'link': item.link,
                  'isOnGoing': item.isOnGoing ? 1 : 0,
                  'isCompleted': item.isCompleted ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DbTaskEntity> _dbTaskEntityInsertionAdapter;

  final UpdateAdapter<DbTaskEntity> _dbTaskEntityUpdateAdapter;

  final DeletionAdapter<DbTaskEntity> _dbTaskEntityDeletionAdapter;

  @override
  Future<void> deleteTasksFromIndex(int index) async {
    await _queryAdapter.queryNoReturn('DELETE FROM task_table WHERE id >= ?1',
        arguments: [index]);
  }

  @override
  Future<List<DbTaskEntity>> findAllTasks() async {
    return _queryAdapter.queryList(
        'SELECT * FROM task_table order by sortId ASC',
        mapper: (Map<String, Object?> row) => DbTaskEntity(
            id: row['id'] as int,
            sortId: row['sortId'] as int,
            title: row['title'] as String,
            content: row['content'] as String,
            category: row['category'] as String,
            dueDateMilliSeconds: row['dueDateMilliSeconds'] as int?,
            link: row['link'] as String,
            isOnGoing: (row['isOnGoing'] as int) != 0,
            isCompleted: (row['isCompleted'] as int) != 0));
  }

  @override
  Future<List<DbTaskEntity>> findPendingTasks() async {
    return _queryAdapter.queryList(
        'SELECT * FROM task_table WHERE isOnGoing = 0 AND isCompleted = 0 ORDER BY sortId ASC',
        mapper: (Map<String, Object?> row) => DbTaskEntity(
            id: row['id'] as int,
            sortId: row['sortId'] as int,
            title: row['title'] as String,
            content: row['content'] as String,
            category: row['category'] as String,
            dueDateMilliSeconds: row['dueDateMilliSeconds'] as int?,
            link: row['link'] as String,
            isOnGoing: (row['isOnGoing'] as int) != 0,
            isCompleted: (row['isCompleted'] as int) != 0));
  }

  @override
  Future<List<DbTaskEntity>> findOngoingTasks() async {
    return _queryAdapter.queryList(
        'SELECT * FROM task_table WHERE isOnGoing = 1 AND isCompleted = 0 ORDER BY sortId ASC',
        mapper: (Map<String, Object?> row) => DbTaskEntity(
            id: row['id'] as int,
            sortId: row['sortId'] as int,
            title: row['title'] as String,
            content: row['content'] as String,
            category: row['category'] as String,
            dueDateMilliSeconds: row['dueDateMilliSeconds'] as int?,
            link: row['link'] as String,
            isOnGoing: (row['isOnGoing'] as int) != 0,
            isCompleted: (row['isCompleted'] as int) != 0));
  }

  @override
  Future<List<DbTaskEntity>> findCompletedTasks() async {
    return _queryAdapter.queryList(
        'SELECT * FROM task_table WHERE isCompleted = 1 ORDER BY sortId ASC',
        mapper: (Map<String, Object?> row) => DbTaskEntity(
            id: row['id'] as int,
            sortId: row['sortId'] as int,
            title: row['title'] as String,
            content: row['content'] as String,
            category: row['category'] as String,
            dueDateMilliSeconds: row['dueDateMilliSeconds'] as int?,
            link: row['link'] as String,
            isOnGoing: (row['isOnGoing'] as int) != 0,
            isCompleted: (row['isCompleted'] as int) != 0));
  }

  @override
  Future<DbTaskEntity?> findTaskById(int id) async {
    return _queryAdapter.query('SELECT * FROM task_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DbTaskEntity(
            id: row['id'] as int,
            sortId: row['sortId'] as int,
            title: row['title'] as String,
            content: row['content'] as String,
            category: row['category'] as String,
            dueDateMilliSeconds: row['dueDateMilliSeconds'] as int?,
            link: row['link'] as String,
            isOnGoing: (row['isOnGoing'] as int) != 0,
            isCompleted: (row['isCompleted'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> updateTaskToPending(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE task_table SET isOnGoing = 0, isCompleted = 0 WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> updateTaskToOngoing(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE task_table SET isOnGoing = 1, isCompleted = 0 WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> updateTaskToCompleted(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE task_table SET isOnGoing = 0, isCompleted = 1 WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insertTask(DbTaskEntity task) {
    return _dbTaskEntityInsertionAdapter.insertAndReturnId(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertTasks(List<DbTaskEntity> tasks) {
    return _dbTaskEntityInsertionAdapter.insertListAndReturnIds(
        tasks, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(DbTaskEntity task) async {
    await _dbTaskEntityUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTask(DbTaskEntity task) async {
    await _dbTaskEntityDeletionAdapter.delete(task);
  }
}
