import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/values/localization/locales_keys.dart';
import 'package:getx_todo_task/app/modules/tasks_page/controllers/tasks_page_controller.dart';
import 'package:getx_todo_task/app/routes/app_pages.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsView extends GetView<TaskDetailsController> {
  const TaskDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.taskDetails.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    controller.taskModel.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  LocaleKeys.description.tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: controller.taskModel.isCompleted
                        ? Colors.green
                        : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    controller.taskModel.isCompleted
                        ? LocaleKeys.done.tr
                        : LocaleKeys.active.tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                controller.taskModel.description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 40,
                    ),
                    onPressed: () {
                      Get.offNamed(
                        Routes.ADD_TASK,
                        arguments: controller.taskModel,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        title: LocaleKeys.deleteTask.tr,
                        content: Text(
                          LocaleKeys.deleteTaskConfirmation.tr,
                        ),
                        contentPadding: EdgeInsets.all(20),
                        onCancel: () {},
                        onConfirm: () {
                          TasksController tasksController =
                              Get.find<TasksController>();

                          tasksController.deleteTask(
                            taskId: controller.taskModel.id,
                          );
                          Get.back();
                          Get.back();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
