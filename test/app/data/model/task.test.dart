import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/common/util/date_util.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';
import 'package:to_do_list/app/data/model/task.dart';

void main() {
  group('Task model', () {
    test('Task.newSimpleTask creates a simple task', () {
      final task = Task.newSimpleTask('New Task', TaskCategory.personal, DateTime(2023, 1, 1));

      expect(task.id, isNotNull);
      expect(task.sortId, isNotNull);
      expect(task.title, 'New Task');
      expect(task.content, '');
      expect(task.dueDate, DateTime(2023, 1, 1));
      expect(task.category, TaskCategory.personal);
      expect(task.link, '');
      expect(task.status, TaskStatus.pending);
    });

    test('Task.fromDataBase creates a task from a database entity', () {
      final dbTaskEntity = DbTaskEntity(
        id: 1,
        sortId: 2,
        title: 'Database Task',
        content: 'Content from database',
        dueDateMilliSeconds: DateTime(2023, 1, 1).millisecondsSinceEpoch,
        link: 'http://naver.com',
        category: 'personal',
        isOnGoing: true,
        isCompleted: false,
      );

      final task = Task.fromDataBase(dbTaskEntity);

      expect(task.id, 1);
      expect(task.sortId, 2);
      expect(task.title, 'Database Task');
      expect(task.content, 'Content from database');
      expect(task.dueDate, DateTime(2023, 1, 1));
      expect(task.link, 'http://naver.com');
      expect(task.category, TaskCategory.personal);
      expect(task.status, TaskStatus.ongoing);
    });

    test('Task.toDataBaseEntity converts a task to a database entity', () {
      final task = Task(
        id: 1,
        sortId: 2,
        title: 'Task Title',
        content: 'Task Content',
        dueDate: DateTime(2023, 1, 1),
        link: 'http://naver.com',
        category: TaskCategory.personal,
        status: TaskStatus.ongoing,
      );

      final dbTaskEntity = task.toDataBaseEntity();

      expect(dbTaskEntity.id, 1);
      expect(dbTaskEntity.sortId, 2);
      expect(dbTaskEntity.title, 'Task Title');
      expect(dbTaskEntity.content, 'Task Content');
      expect(dbTaskEntity.dueDateMilliSeconds, DateTime(2023, 1, 1).millisecondsSinceEpoch);
      expect(dbTaskEntity.link, 'http://naver.com');
      expect(dbTaskEntity.category, '개인');
      expect(dbTaskEntity.isOnGoing, true);
      expect(dbTaskEntity.isCompleted, false);
    });

    test('Task.toString returns a correct string representation', () {
      final task = Task(
        id: 1,
        sortId: 2,
        title: 'Task Title',
        content: 'Task Content',
        dueDate: DateTime(2023, 1, 1),
        link: 'http://naver.com',
        category: TaskCategory.personal,
        status: TaskStatus.ongoing,
      );

      final taskString = task.toString();

      expect(
        taskString,
        'Task{id: 1, title: Task Title, content: Task Content, dueDate: 2023-01-01 00:00:00.000, link: http://naver.com, category: TaskCategory.personal, status: TaskStatus.ongoing}',
      );
    });
  });
}
