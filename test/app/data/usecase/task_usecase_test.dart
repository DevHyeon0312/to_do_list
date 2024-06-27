import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/app/data/usecase/task_usecase.dart';
import 'package:to_do_list/core/local_db/entity/db_task_entity.dart';
import 'package:to_do_list/core/local_db/repository/database_task_repository.dart';

import 'task_usecase_test.mocks.dart';

@GenerateMocks([DatabaseTaskRepository])
void main() {
  late TaskUseCase taskUseCase;
  late MockDatabaseTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockDatabaseTaskRepository();
    taskUseCase = TaskUseCase(taskRepository: Future.value(mockRepository));
  });

  group('TaskUseCase', () {
    test('getAllTasks returns a list of tasks', () async {
      when(mockRepository.findAllTasks()).thenAnswer((_) async => [
        DbTaskEntity(
          id: 1,
          sortId: 1,
          title: 'Task 1',
          content: 'Content 1',
          dueDateMilliSeconds: 123456789,
          link: 'link1',
          category: 'personal',
          isOnGoing: false,
          isCompleted: false,
        ),
      ]);

      final tasks = await taskUseCase.getAllTasks();
      expect(tasks, isA<List<Task>>());
      expect(tasks.length, 1);
      expect(tasks.first.title, 'Task 1');
    });

    test('addTask adds a task', () async {
      final task = Task(
        id: 1,
        sortId: 1,
        title: 'Task 1',
        content: 'Content 1',
        dueDate: DateTime.now(),
        link: 'link1',
        category: TaskCategory.personal,
        status: TaskStatus.pending,
      );

      when(mockRepository.insertTask(any)).thenAnswer((_) async => 1);

      final result = await taskUseCase.addTask(task);
      expect(result, 1);
    });

    test('deleteTask deletes a task', () async {
      final task = Task(
        id: 1,
        sortId: 1,
        title: 'Task 1',
        content: 'Content 1',
        dueDate: DateTime.now(),
        link: 'link1',
        category: TaskCategory.personal,
        status: TaskStatus.pending,
      );

      when(mockRepository.deleteTask(any)).thenAnswer((_) async => null);

      await taskUseCase.deleteTask(task);
      verify(mockRepository.deleteTask(any)).called(1);
    });

    test('updateTask updates a task', () async {
      final task = Task(
        id: 1,
        sortId: 1,
        title: 'Task 1',
        content: 'Content 1',
        dueDate: DateTime.now(),
        link: 'link1',
        category: TaskCategory.personal,
        status: TaskStatus.pending,
      );

      when(mockRepository.updateTask(any)).thenAnswer((_) async => null);

      await taskUseCase.updateTask(task);
      verify(mockRepository.updateTask(any)).called(1);
    });

    test('getPendingTaskList returns a list of pending tasks', () async {
      when(mockRepository.findPendingTasks()).thenAnswer((_) async => [
        DbTaskEntity(
          id: 1,
          sortId: 1,
          title: 'Task 1',
          content: 'Content 1',
          dueDateMilliSeconds: 123456789,
          link: 'link1',
          category: 'personal',
          isOnGoing: false,
          isCompleted: false,
        ),
      ]);

      final tasks = await taskUseCase.getPendingTaskList();
      expect(tasks, isA<List<Task>>());
      expect(tasks.length, 1);
      expect(tasks.first.title, 'Task 1');
    });

    test('getOngoingTaskList returns a list of ongoing tasks', () async {
      when(mockRepository.findOngoingTasks()).thenAnswer((_) async => [
        DbTaskEntity(
          id: 1,
          sortId: 1,
          title: 'Task 1',
          content: 'Content 1',
          dueDateMilliSeconds: 123456789,
          link: 'link1',
          category: 'personal',
          isOnGoing: true,
          isCompleted: false,
        ),
      ]);

      final tasks = await taskUseCase.getOngoingTaskList();
      expect(tasks, isA<List<Task>>());
      expect(tasks.length, 1);
      expect(tasks.first.title, 'Task 1');
    });

    test('getCompletedTaskList returns a list of completed tasks', () async {
      when(mockRepository.findCompletedTasks()).thenAnswer((_) async => [
        DbTaskEntity(
          id: 1,
          sortId: 1,
          title: 'Task 1',
          content: 'Content 1',
          dueDateMilliSeconds: 123456789,
          link: 'link1',
          category: 'personal',
          isOnGoing: false,
          isCompleted: true,
        ),
      ]);

      final tasks = await taskUseCase.getCompletedTaskList();
      expect(tasks, isA<List<Task>>());
      expect(tasks.length, 1);
      expect(tasks.first.title, 'Task 1');
    });
  });
}
