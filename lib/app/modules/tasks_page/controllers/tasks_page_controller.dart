// import 'package:get/get.dart';
// import 'package:getx_todo_task/app/core/utils/utils.dart';
// import 'package:getx_todo_task/app/data/models/task_model.dart';
// import 'package:getx_todo_task/app/data/providers/tasks_provider.dart';

// class TasksController extends GetxController {
//   final TasksProvider tasksProvider = Get.find<TasksProvider>();

//   RxList<TaskModel> tasks = <TaskModel>[].obs;
//   final RxBool isLoading = RxBool(true);

//   void getAllTasks() async {
//     try {
//       print("==============before==============");
//       tasks.value = await tasksProvider.getTasks();
//       print("==============after==============");
//       isLoading.value = false;
//     } catch (e) {
//       Utils.showErrorSnackBar(
//         title: "Error Getting Tasks",
//         message: e.toString(),
//       );
//       isLoading.value = false;
//     }
//   }

//   Future<void> addTask() async {
//     TaskModel newTask = TaskModel(
//       id: "1",
//       title: "Dummy Task xfvdxfvddxfvddfvfvssfdvb",
//       description: 'This is another dummy task',
//       isCompleted: false,
//     );

//     try {
//       TaskModel addedTask = await tasksProvider.addTask(newTask);
//       tasks.add(addedTask);
//     } catch (e) {
//       Utils.showErrorSnackBar(
//         title: "Error Adding Task",
//         message: e.toString(),
//       );
//     }
//   }

//   Future<void> editTask({
//     required TaskModel updatedTask,
//   }) async {
//     try {
//       // TaskModel updatedTask = await tasksProvider.editTask(taskId,updatedData);
//       TaskModel newTask = await tasksProvider.editTask(updatedTask);
//       int taskIndex = tasks.indexWhere((task) => task.id == updatedTask.id);
//       tasks[taskIndex] = newTask;
//     } catch (e) {
//       Utils.showErrorSnackBar(
//         title: "Error Adding Task",
//         message: e.toString(),
//       );
//     }
//   }

//   @override
//   void onInit() async {
//     getAllTasks();
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/utils/utils.dart';
import 'package:getx_todo_task/app/core/values/localization/locales_keys.dart';
import 'package:getx_todo_task/app/data/models/task_model.dart';
import 'package:getx_todo_task/app/data/providers/tasks_provider.dart';

class TasksController extends GetxController with StateMixin<List<TaskModel>> {
  final TasksProvider tasksProvider = Get.find<TasksProvider>();

  @override
  void onInit() {
    super.onInit();
    getAllTasks();
  }

  void getAllTasks() async {
    try {
      change(null, status: RxStatus.loading());
      final tasks = await tasksProvider.getTasks();
      if (tasks.isEmpty) {
        change(tasks, status: RxStatus.empty());
      } else {
        change(tasks, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      Utils.showCustomSnackBar(
        title: LocaleKeys.getTasksError.tr,
        message: e.toString(),
      );
    }
  }

  Future<void> addTask({
    required TaskModel newTask,
  }) async {
    try {
      TaskModel addedTask = await tasksProvider.addTask(newTask);
      if (state != null) {
        final updatedTasks = List<TaskModel>.from(state!)..add(addedTask);
        change(updatedTasks, status: RxStatus.success());
      }
    } catch (e) {
      Utils.showCustomSnackBar(
        title: LocaleKeys.addTaskError.tr,
        message: e.toString(),
      );
    }
  }

  Future<void> editTask({
    required TaskModel updatedTask,
  }) async {
    try {
      TaskModel newTask = await tasksProvider.editTask(updatedTask);
      if (state != null) {
        final updatedTasks = List<TaskModel>.from(state!);
        final taskIndex =
            updatedTasks.indexWhere((task) => task.id == updatedTask.id);
        if (taskIndex != -1) {
          updatedTasks[taskIndex] = newTask;
          change(updatedTasks, status: RxStatus.success());
        }
      }
    } catch (e) {
      Utils.showCustomSnackBar(
        title: LocaleKeys.editTaskError.tr,
        message: e.toString(),
      );
    }
  }

  Future<void> deleteTask({
    required String taskId,
  }) async {
    try {
      bool isDeleted = await tasksProvider.deleteTask(taskId);
      if (isDeleted && state != null) {
        state!.removeWhere((task) => task.id == taskId);

        change(state,
            status: state!.isEmpty ? RxStatus.empty() : RxStatus.success());
        Utils.showCustomSnackBar(
          title: LocaleKeys.deleteTaskSuccess.tr,
          isError: false,
        );
      }
    } catch (e) {
      Utils.showCustomSnackBar(
        title: LocaleKeys.deleteTaskError.tr,
        message: e.toString(),
      );
    }
  }
}
