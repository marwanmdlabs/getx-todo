import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/utils/utils.dart';
import 'package:getx_todo_task/app/core/values/local_storage_constants.dart';
import 'package:getx_todo_task/app/core/values/localization/locales_keys.dart';
import 'package:getx_todo_task/app/data/models/task_model.dart';
import 'package:getx_todo_task/app/data/providers/tasks_provider.dart';
import 'package:getx_todo_task/app/data/services/internet_connectivity_service.dart';
import 'package:hive/hive.dart';

class TasksController extends GetxController with StateMixin<List<TaskModel>> {
  final TasksProvider tasksProvider = Get.find<TasksProvider>();
  final InternetConnectivityService internetConnectivityService =
      Get.find<InternetConnectivityService>();
  late Box<TaskModel> tasksBox;
  @override
  void onInit() {
    super.onInit();
    tasksBox = Hive.box<TaskModel>(LocalStorageConstants.tasksBox);
    getAllTasks();
  }

  void getAllTasks() async {
    try {
      List<TaskModel> tasks = [];
      change(null, status: RxStatus.loading());
      if (!internetConnectivityService.isInternetAvailable.value) {
        tasks = tasksBox.values.toList();
      } else {
        tasks = await tasksProvider.getTasks();
        await tasksBox.addAll(tasks);
      }
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
      final TaskModel addedTask = await tasksProvider.addTask(newTask);
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
      final TaskModel newTask = await tasksProvider.editTask(updatedTask);
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
      final bool isDeleted = await tasksProvider.deleteTask(taskId);
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
