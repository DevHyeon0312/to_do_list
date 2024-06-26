import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';
import 'package:to_do_list/app/feature/task/widget/simple_add_task_widget.dart';
import 'package:to_do_list/common/widget/animation_floating_action_button.dart';

class TaskAllListPage extends StatefulWidget {
  const TaskAllListPage({super.key});

  @override
  State<TaskAllListPage> createState() => _TaskAllListPageState();
}

class _TaskAllListPageState extends State<TaskAllListPage> {
  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    taskController.getMockTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할일 목록'),
      ),
      backgroundColor: Colors.white,
      body: Obx(
          () {
            if (taskController.taskList.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: taskController.taskList.length,
              itemBuilder: (context, index) {
                final task = taskController.taskList[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.content),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      taskController.deleteTask(task.id);
                    },
                  ),
                  onTap: () {

                  },
                );
              },
            );
          }
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
                  //TODO : Add Task
                  FocusScope.of(context).unfocus();
                },
              );
            },
          );
        },
      ),
    );
  }
}
