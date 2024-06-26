import 'package:floor/floor.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';

@dao
abstract class DbTaskDao {
  // 전체 TASK 를 id 순으로 조회
  @Query('SELECT * FROM task_table ORDER BY id DESC')
  Future<List<DbTaskEntity>> findAllTasks();

  // 진행중인 TASK 를 id 순으로 조회
  @Query('SELECT * FROM task_table WHERE isOnGoing = 1 ORDER BY id DESC')
  Future<List<DbTaskEntity>> findOngoingTasks();

  // 완료된 TASK 를 id 순으로 조회
  @Query('SELECT * FROM task_table WHERE isCompleted = 1 ORDER BY id DESC')
  Future<List<DbTaskEntity>> findCompletedTasks();

  // id 로 TASK 조회
  @Query('SELECT * FROM task_table WHERE id = :id')
  Future<DbTaskEntity?> findTaskById(int id);

  // TASK 등록
  @insert
  Future<void> insertTask(DbTaskEntity task);

  // TASK 수정
  @update
  Future<void> updateTask(DbTaskEntity task);

  // TASK 상태를 초기값으로 변경
  @Query('UPDATE task_table SET isOnGoing = 0, isCompleted = 0 WHERE id = :id')
  Future<void> updateTaskToInitial(int id);

  // TASK 진행중으로 변경
  @Query('UPDATE task_table SET isOnGoing = 1, isCompleted = 0 WHERE id = :id')
  Future<void> updateTaskToOngoing(int id);

  // TASK 완료로 변경
  @Query('UPDATE task_table SET isOnGoing = 0, isCompleted = 1 WHERE id = :id')
  Future<void> updateTaskToCompleted(int id);

  // TASK 와 TASK 의 순서 변경
  @Query('UPDATE task_table SET id = :newId WHERE id = :oldId')
  Future<void> updateTaskOrder(int oldId, int newId);

  // TASK 삭제
  @delete
  Future<void> deleteTask(DbTaskEntity task);
}