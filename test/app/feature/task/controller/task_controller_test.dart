import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/app/data/usecase/task_usecase.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';
import 'task_controller_test.mocks.dart';

@GenerateMocks([TaskUseCase])
void main() {
  late TaskController taskController;
  late MockTaskUseCase mockTaskUseCase;

  setUp(() {
    mockTaskUseCase = MockTaskUseCase();
    taskController = TaskController(taskUseCase: mockTaskUseCase);
  });

  group('TaskController', () {
    test('createNewTask adds a task to pendingTaskList', () async {
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

      when(mockTaskUseCase.addTask(any)).thenAnswer((_) async => 1);

      await taskController.createNewTask(task);

      expect(taskController.pendingTaskList.length, 1);
      expect(taskController.pendingTaskList.first.title, 'Task 1');
    });

    test('getTaskList with pending status fetches pending tasks', () async {
      when(mockTaskUseCase.getPendingTaskList()).thenAnswer((_) async => [
        Task(
          id: 1,
          sortId: 1,
          title: 'Task 1',
          content: 'Content 1',
          dueDate: DateTime.now(),
          link: 'link1',
          category: TaskCategory.personal,
          status: TaskStatus.pending,
        ),
      ]);

      await taskController.getTaskList(TaskStatus.pending);

      expect(taskController.pendingTaskList.length, 1);
      expect(taskController.pendingTaskList.first.title, 'Task 1');
    });

    test('getTaskList with ongoing status fetches ongoing tasks', () async {
      when(mockTaskUseCase.getOngoingTaskList()).thenAnswer((_) async => [
        Task(
          id: 1,
          sortId: 1,
          title: 'Task 1',
          content: 'Content 1',
          dueDate: DateTime.now(),
          link: 'link1',
          category: TaskCategory.personal,
          status: TaskStatus.ongoing,
        ),
      ]);

      await taskController.getTaskList(TaskStatus.ongoing);

      expect(taskController.ongoingTaskList.length, 1);
      expect(taskController.ongoingTaskList.first.title, 'Task 1');
    });

    test('getTaskList with completed status fetches completed tasks', () async {
      when(mockTaskUseCase.getCompletedTaskList()).thenAnswer((_) async => [
        Task(
          id: 1,
          sortId: 1,
          title: 'Task 1',
          content: 'Content 1',
          dueDate: DateTime.now(),
          link: 'link1',
          category: TaskCategory.personal,
          status: TaskStatus.completed,
        ),
      ]);

      await taskController.getTaskList(TaskStatus.completed);

      expect(taskController.completedTaskList.length, 1);
      expect(taskController.completedTaskList.first.title, 'Task 1');
    });

    test('deleteTask removes the task from the list', () async {
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

      taskController.pendingTaskList.add(task);

      when(mockTaskUseCase.deleteTask(any)).thenAnswer((_) async => null);

      await taskController.deleteTask(taskController.pendingTaskList, task);

      expect(taskController.pendingTaskList.length, 0);
    });

    test('updateTask updates the task in the list', () async {
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

      final updatedTask = Task(
        id: 1,
        sortId: 1,
        title: 'Updated Task 1',
        content: 'Updated Content 1',
        dueDate: DateTime.now(),
        link: 'link1',
        category: TaskCategory.personal,
        status: TaskStatus.pending,
      );

      taskController.pendingTaskList.add(task);

      when(mockTaskUseCase.updateTask(any)).thenAnswer((_) async => updatedTask);

      await taskController.updateTask(TaskStatus.pending, updatedTask);

      expect(taskController.pendingTaskList.length, 1);
      expect(taskController.pendingTaskList.first.title, 'Updated Task 1');
    });

    test('changeTaskPosition changes the position of the task in the list', () async {
      var task1Id = DateTime.now().millisecondsSinceEpoch;
      final task1 = Task(
        id: task1Id,
        sortId: task1Id,
        title: 'Task 1',
        content: 'Content 1',
        dueDate: DateTime.now(),
        link: 'link1',
        category: TaskCategory.personal,
        status: TaskStatus.pending,
      );

      var task2Id = DateTime.now().millisecondsSinceEpoch + 100000;
      final task2 = Task(
        id: task2Id,
        sortId: task2Id,
        title: 'Task 2',
        content: 'Content 2',
        dueDate: DateTime.now(),
        link: 'link2',
        category: TaskCategory.work,
        status: TaskStatus.pending,
      );

      taskController.pendingTaskList.addAll([task1, task2]);

      when(mockTaskUseCase.updateTask(any)).thenAnswer((_) async => task2);

      await taskController.changeTaskPosition(taskController.pendingTaskList, 0, 1);

      expect(taskController.pendingTaskList.length, 2);
      expect(taskController.pendingTaskList.first.title, 'Task 1');
      expect(taskController.pendingTaskList.last.title, 'Task 2');
    });
  });
}
