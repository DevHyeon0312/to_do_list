import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';
import 'package:to_do_list/app/feature/task/controller/task_ongoing_controller.dart';
import 'package:to_do_list/app/feature/task/controller/task_pending_controller.dart';
import 'package:to_do_list/app/feature/task/widget/simple_add_task_widget.dart';
import 'package:to_do_list/common/widget/animation_floating_action_button.dart';

class TaskPendingPage extends StatefulWidget {
  const TaskPendingPage({super.key});

  @override
  State<TaskPendingPage> createState() => _TaskPendingPageState();
}

class _TaskPendingPageState extends State<TaskPendingPage> {
  final pendingTaskController = Get.put(TaskPendingController());

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
            var loading = pendingTaskController.isLoading;
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
            final pendingTaskList = pendingTaskController.pendingTaskList;
            return ReorderableListView.builder(
              onReorder: (int oldIndex, int newIndex) {
                pendingTaskController.changeTaskPosition(oldIndex, newIndex);
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
                      pendingTaskController.startTask(item);
                    } else if (direction == DismissDirection.endToStart) {
                      pendingTaskController.deleteTask(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('할일이 삭제되었습니다.'),
                          action: SnackBarAction(
                            label: '취소',
                            onPressed: () {
                              pendingTaskController.insertTask(item, index);
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
      floatingActionButton: AnimationFloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            backgroundColor: Colors.white,
            builder: (BuildContext context) {
              return SimpleAddTaskWidget(
                onSubmit: (title, category, dueDate) {
                  FocusScope.of(context).unfocus();
                  pendingTaskController.addTask(title, category, dueDate);
                },
              );
            },
          );
        },
      ),
    );
  }
}
