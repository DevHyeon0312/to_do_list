import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/task/controller/task_pending_controller.dart';
import 'package:to_do_list/app/feature/task/widget/simple_add_task_widget.dart';
import 'package:to_do_list/app/feature/task/widget/task_card.dart';
import 'package:to_do_list/app/navigation/app_route.dart';
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
        title: const Text('완료'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
                return TaskCard(
                  key: ValueKey(item.id),
                  position: index,
                  task: item,
                  onStart: () {
                    pendingTaskController.startTask(item);
                  },
                  onCompleted: () {
                    pendingTaskController.completeTask(item);
                  },
                  onDelete: () {
                    pendingTaskController.deleteTask(item);
                  },
                  onTap: () {
                    Get.toNamed(
                      AppRoute.taskDetail.name,
                      arguments: item,
                    );
                  },
                );
              },
              buildDefaultDragHandles: false,
            );
          }),
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
