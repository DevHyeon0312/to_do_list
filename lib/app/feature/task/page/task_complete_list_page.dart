import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/task/controller/task_complete_controller.dart';
import 'package:to_do_list/app/feature/task/widget/task_card.dart';
import 'package:to_do_list/app/navigation/app_route.dart';

/// [TaskCompleteListPage] 완료 페이지 : [MainPage]에서 완료 탭을 눌렀을 때 보여지는 페이지
/// * [TaskCard] 할일 카드 위젯
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
          // list widget
          Obx(() {
            final completeTaskList = completeTaskController.completedTaskList;
            return ReorderableListView.builder(
              onReorder: (int oldIndex, int newIndex) {
                completeTaskController.changeTaskPosition(oldIndex, newIndex);
              },
              itemCount: completeTaskList.length,
              itemBuilder: (context, index) {
                final item = completeTaskList[index];
                return TaskCard(
                  key: ValueKey(item.id),
                  position: index,
                  task: item,
                  onStart: () {},
                  onCompleted: () {},
                  onDelete: () {
                    completeTaskController.deleteTask(item);
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
            var loading = completeTaskController.isLoading;
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
