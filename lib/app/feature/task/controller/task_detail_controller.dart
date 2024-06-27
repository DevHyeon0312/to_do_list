import 'package:get/get.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/app/feature/task/controller/task_controller.dart';

///
/// [TaskDetailController] 할일을 수정하는 화면의 Controller
/// * [setTask] 할일 정보를 설정
/// * [updateTask] 할일을 수정
///
class TaskDetailController extends GetxController {
  final TaskController _taskController = Get.find<TaskController>();

  final isLoading = false.obs;

  var oldId = -1;
  var oldSortId = -1;
  TaskStatus? oldTaskStatus;

  var title = ''.obs;
  var content = ''.obs;
  var dueDate = Rx<DateTime?>(null);
  var link = ''.obs;
  var category = Rx<TaskCategory?>(null);
  var status = Rx<TaskStatus?>(null);

  void setTask(Task task) {
    oldId = task.id;
    oldSortId = task.sortId;
    oldTaskStatus = task.status;
    title.value = task.title;
    content.value = task.content;
    dueDate.value = task.dueDate;
    link.value = task.link;
    category.value = task.category;
    status.value = task.status;
  }

  void updateTask() {
    isLoading.value = true;
    Task task = Task(
      id: oldId,
      sortId: oldSortId,
      title: title.value,
      content: content.value,
      dueDate: dueDate.value,
      link: link.value,
      category: category.value!,
      status: status.value!,
    );
    _taskController.updateTask(oldTaskStatus, task).then((_) {
      Get.back(result: task);
    }).catchError((error) {
      Get.snackbar('에러', '할일 수정에 실패했습니다.');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }
}
