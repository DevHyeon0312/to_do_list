import 'dart:async';
import 'package:floor/floor.dart';
import 'package:to_do_list/core/local_db/dao/db_task_dao.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'task_database.g.dart';
@Database(version: 1, entities: [DbTaskEntity])
abstract class TaskDatabase extends FloorDatabase {
  DbTaskDao get taskDao;
}