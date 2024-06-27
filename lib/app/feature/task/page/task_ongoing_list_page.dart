import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/task/controller/task_ongoing_controller.dart';

class TaskOngoingListPage extends StatefulWidget {
  const TaskOngoingListPage({super.key});

  @override
  State<TaskOngoingListPage> createState() => _TaskOngoingListPageState();
}

class _TaskOngoingListPageState extends State<TaskOngoingListPage> {
  final taskOngoingController = Get.put(TaskOngoingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('진행중'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // loading widget
          Obx(() {
            var loading = taskOngoingController.isLoading;
            if (loading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          // list widget
          Obx(() {
            final pendingTaskList = taskOngoingController.ongoingTaskList;
            return ReorderableListView.builder(
              onReorder: (int oldIndex, int newIndex) {
                taskOngoingController.changeTaskPosition(oldIndex, newIndex);
              },
              itemCount: pendingTaskList.length,
              itemBuilder: (context, index) {
                final item = pendingTaskList[index];
                return Dismissible(
                  key: ValueKey(item.id),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.play_arrow, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      taskOngoingController.completeTask(item);
                    } else if (direction == DismissDirection.endToStart) {
                      taskOngoingController.deleteTask(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('할일이 삭제되었습니다.'),
                          action: SnackBarAction(
                            label: '취소',
                            onPressed: () {
                              taskOngoingController.insertTask(item, index);
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: ListTile(
                    key: ValueKey(item.id),
                    title: Text(item.title),
                    subtitle: Text(
                      '할일: ${item.title}\n'
                          '카테고리: ${item.category}\n'
                          'sortId: ${item.sortId}\n'
                          '마감일: ${item.dueDate}',
                    ),
                    onTap: () {},
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}