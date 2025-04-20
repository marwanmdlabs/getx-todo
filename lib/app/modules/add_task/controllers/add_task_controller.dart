import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/utils/utils.dart';
import 'package:getx_todo_task/app/core/values/localization/locales_keys.dart';
import 'package:getx_todo_task/app/data/models/task_model.dart';
import 'package:getx_todo_task/app/modules/tasks_page/controllers/tasks_page_controller.dart';

class AddTaskController extends GetxController {
  TasksController tasksController = Get.find<TasksController>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  final RxBool isEditTask = false.obs;
  TaskModel? taskData;
  @override
  void onInit() {
    super.onInit();
    taskData = Get.arguments as TaskModel?;

    titleController = TextEditingController(text: taskData?.title ?? '');
    descriptionController =
        TextEditingController(text: taskData?.description ?? '');

    if (taskData != null) {
      isEditTask.value = true;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  String? validateField(String? value) {
    if (GetUtils.isBlank(value) ?? false) {
      return LocaleKeys.emptyFieldError.tr;
    }
    return null;
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    if (isEditTask.value) {
      final TaskModel newTaskModel = TaskModel(
        id: taskData!.id,
        title: titleController.text,
        description: descriptionController.text,
        isCompleted: taskData!.isCompleted,
      );
      tasksController.editTask(updatedTask: newTaskModel);
    } else {
      final TaskModel newTaskModel = TaskModel(
        id: ((tasksController.state?.length ?? 0) + 1).toString(),
        title: titleController.text,
        description: descriptionController.text,
        isCompleted: false,
      );
      tasksController.addTask(newTask: newTaskModel);
    }
    Get.back();
    Utils.showCustomSnackBar(
      title: LocaleKeys.success.tr,
      message: isEditTask.value
          ? LocaleKeys.editTaskSuccess.tr
          : LocaleKeys.addTaskSuccess.tr,
      isError: false,
    );
  }
}
