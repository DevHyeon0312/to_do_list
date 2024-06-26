import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/common/util/date_util.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';

/// Task model
/// * [id] task id
/// * [title] task 제목
/// * [content] task 내용
/// * [dueDate] task 마감일
/// * [link] task 관련링크
/// * [category] task 카테고리
/// * [status] task 상태
class Task {
  int id;
  String title;
  String content;
  DateTime dueDate;
  String link;
  TaskCategory category;
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.dueDate,
    required this.category,
    required this.link,
    required this.status,
  });

  factory Task.fromDataBase(DbTaskEntity entity) {
    return Task(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      dueDate: DateUtil.milliSecondsToDateTime(entity.dueDateMilliSeconds),
      link: entity.link,
      category: TaskCategory.fromString(entity.category),
      status: TaskStatus.pending,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, content: $content, dueDate: $dueDate, link: $link, category: $category, status: $status}';
  }
}