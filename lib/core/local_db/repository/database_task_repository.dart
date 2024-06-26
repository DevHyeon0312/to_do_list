import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';

abstract class DatabaseTaskRepository {

  // 전체 TASK 를 id 순으로 조회
  Future<List<DbTaskEntity>> findAllTasks();

  // 진행중인 TASK 를 id 순으로 조회
  Future<List<DbTaskEntity>> findOngoingTasks();

  // 완료된 TASK 를 id 순으로 조회
  Future<List<DbTaskEntity>> findCompletedTasks();

  // id 로 TASK 조회
  Future<DbTaskEntity?> findTaskById(int id);

  // TASK 등록
  Future<void> insertTask(DbTaskEntity task);

  // TASK 수정
  Future<void> updateTask(DbTaskEntity task);

  // TASK 상태를 초기값으로 변경
  Future<void> updateTaskToInitial(int id);

  // TASK 진행중으로 변경
  Future<void> updateTaskToOngoing(int id);

  // TASK 완료로 변경
  Future<void> updateTaskToCompleted(int id);

  // TASK 와 TASK 의 순서 변경
  Future<void> updateTaskOrder(int oldId, int newId);

  // TASK 삭제
  Future<void> deleteTask(DbTaskEntity task);
}