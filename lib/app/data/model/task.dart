import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/common/util/date_util.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';

/// Task model
/// * [id] task id
/// * [sortId] task 정렬 id
/// * [title] task 제목
/// * [content] task 내용
/// * [dueDate] task 마감일
/// * [link] task 관련링크
/// * [category] task 카테고리
/// * [status] task 상태
class Task {
  int id;
  int sortId;
  String title;
  String content;
  DateTime? dueDate;
  String link;
  TaskCategory category;
  TaskStatus status;

  Task({
    required this.id,
    required this.sortId,
    required this.title,
    required this.content,
    required this.dueDate,
    required this.category,
    required this.link,
    required this.status,
  });

  factory Task.newSimpleTask(String title, TaskCategory? category, DateTime? dueDate) {
    return Task(
      id: DateTime.now().millisecondsSinceEpoch,
      sortId: DateTime.now().millisecondsSinceEpoch,
      title: title,
      content: '',
      dueDate: dueDate,
      category: category ?? TaskCategory.none,
      link: '',
      status: TaskStatus.pending,
    );
  }

  factory Task.fromDataBase(DbTaskEntity entity) {
    return Task(
      id: entity.id,
      sortId: entity.sortId,
      title: entity.title,
      content: entity.content,
      dueDate: DateUtil.milliSecondsToDateTime(entity.dueDateMilliSeconds),
      link: entity.link,
      category: TaskCategory.fromString(entity.category),
      status: entity.isOnGoing
          ? TaskStatus.ongoing
          : entity.isCompleted
              ? TaskStatus.completed
              : TaskStatus.pending,
    );
  }

  DbTaskEntity toDataBaseEntity() {
    return DbTaskEntity(
      id: id,
      sortId: sortId,
      title: title,
      content: content,
      dueDateMilliSeconds: dueDate?.millisecondsSinceEpoch,
      link: link,
      category: category.name,
      isOnGoing: status == TaskStatus.ongoing,
      isCompleted: status == TaskStatus.completed,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, content: $content, dueDate: $dueDate, link: $link, category: $category, status: $status}';
  }
}