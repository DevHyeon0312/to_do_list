import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/feature/task/controller/task_detail_controller.dart';
import 'package:to_do_list/common/util/date_util.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final taskDetailController = Get.put(TaskDetailController());

  @override
  void initState() {
    super.initState();
    var arg = Get.arguments;
    taskDetailController.setTask(arg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('할일 상세'),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Obx(() => TextFormField(
                        initialValue: taskDetailController.title.value,
                        decoration: const InputDecoration(labelText: '제목'),
                        onChanged: (value) {
                          taskDetailController.title.value = value;
                        },
                      )),
                  Obx(() => TextFormField(
                        initialValue: taskDetailController.content.value,
                        decoration: const InputDecoration(labelText: '내용'),
                        onChanged: (value) {
                          taskDetailController.content.value = value;
                        },
                      )),
                  Obx(() => TextFormField(
                        initialValue: taskDetailController.link.value,
                        decoration: const InputDecoration(labelText: '관련링크'),
                        onChanged: (value) {
                          taskDetailController.link.value = value;
                        },
                      )),
                  Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          '마감일: ${DateUtil.getFormattedDate(taskDetailController.dueDate.value)}',
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: taskDetailController.dueDate.value ??
                                DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null &&
                              picked != taskDetailController.dueDate.value) {
                            taskDetailController.dueDate.value = picked;
                          }
                        },
                      )),
                  Row(
                    children: [
                      Obx(() => DropdownButton<TaskCategory>(
                            value: taskDetailController.category.value,
                            items: TaskCategory.values
                                .map((TaskCategory category) {
                              return DropdownMenuItem<TaskCategory>(
                                value: category,
                                child: Text(
                                  category.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: category ==
                                            taskDetailController.category.value
                                        ? Colors.blueAccent
                                        : Colors.black,
                                  ),
                                  textScaler: TextScaler.noScaling,
                                ),
                              );
                            }).toList(),
                            onChanged: (TaskCategory? newValue) {
                              if (newValue != null) {
                                taskDetailController.category.value = newValue;
                              }
                            },
                          )),
                      const SizedBox(width: 20),
                      Obx(() => DropdownButton<TaskStatus>(
                            value: taskDetailController.status.value,
                            items: TaskStatus.values.map((TaskStatus status) {
                              return DropdownMenuItem<TaskStatus>(
                                value: status,
                                child: Text(
                                  status.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: status ==
                                            taskDetailController.status.value
                                        ? Colors.blueAccent
                                        : Colors.black,
                                  ),
                                  textScaler: TextScaler.noScaling,
                                ),
                              );
                            }).toList(),
                            onChanged: (TaskStatus? newValue) {
                              if (newValue != null) {
                                taskDetailController.status.value = newValue;
                              }
                            },
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      taskDetailController.updateTask();
                    },
                    child: const Text('저장하기'),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                var loading = taskDetailController.isLoading;
                if (loading.value) {
                  return Container(
                      color: Colors.white.withOpacity(0.5),
                      width: double.infinity,
                      height: double.infinity,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ));
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ));
  }
}
