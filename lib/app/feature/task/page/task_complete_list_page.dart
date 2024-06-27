import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/task/controller/task_complete_controller.dart';

class TaskCompleteListPage extends StatefulWidget {
  const TaskCompleteListPage({super.key});

  @override
  State<TaskCompleteListPage> createState() => _TaskCompleteListPageState();
}

class _TaskCompleteListPageState extends State<TaskCompleteListPage> {
  final completeTaskController = Get.put(TaskCompleteController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할일'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // loading widget
          Obx(() {
            var loading = completeTaskController.isLoading;
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
            final pendingTaskList = completeTaskController.completedTaskList;
            return ReorderableListView.builder(
              onReorder: (int oldIndex, int newIndex) {
                completeTaskController.changeTaskPosition(oldIndex, newIndex);
              },
              itemCount: pendingTaskList.length,
              itemBuilder: (context, index) {
                final item = pendingTaskList[index];
                return ListTile(
                  key: ValueKey(item.id),
                  title: Text(item.title),
                  subtitle: Text(
                    '할일: ${item.title}\n'
                        '카테고리: ${item.category}\n'
                        'sortId: ${item.sortId}\n'
                        '마감일: ${item.dueDate}',
                  ),
                  onTap: () {},
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
