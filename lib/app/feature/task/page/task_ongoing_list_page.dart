import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/task/controller/task_ongoing_controller.dart';
import 'package:to_do_list/app/feature/task/widget/task_card.dart';
import 'package:to_do_list/app/navigation/app_route.dart';

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
          // list widget
          Obx(() {
            final ongoingTaskList = taskOngoingController.ongoingTaskList;
            return ReorderableListView.builder(
              onReorder: (int oldIndex, int newIndex) {
                taskOngoingController.changeTaskPosition(oldIndex, newIndex);
              },
              itemCount: ongoingTaskList.length,
              itemBuilder: (context, index) {
                final item = ongoingTaskList[index];
                return TaskCard(
                  key: ValueKey(item.id),
                  position: index,
                  task: item,
                  onStart: () {},
                  onCompleted: () {
                    taskOngoingController.completeTask(item);
                  },
                  onDelete: () {
                    taskOngoingController.deleteTask(item);
                  },
                  onTap: () {
                    Get.toNamed(AppRoute.taskDetail.name, arguments: item);
                  },
                );
              },
              buildDefaultDragHandles: false,
            );
          }),
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
        ],
      ),
    );
  }
}
