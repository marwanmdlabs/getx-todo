import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/values/localization/locales_keys.dart';
import 'package:getx_todo_task/app/modules/tasks_page/views/widgets/task_card.dart';
import 'package:getx_todo_task/app/routes/app_pages.dart';

import '../controllers/tasks_page_controller.dart';

class TasksPageView extends GetView<TasksController> {
  const TasksPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
          ),
          child: Text(LocaleKeys.todoList.tr),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
          ),
          child: IconButton(
            onPressed: () => Get.toNamed(
              Routes.SETTINGS,
            ),
            icon: Icon(
              Icons.settings,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            Routes.ADD_TASK,
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: controller.obx(
          (tasks) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: tasks!.length,
              itemBuilder: (context, index) => TaskCard(
                taskModel: tasks[index],
                onToggle: (val) {
                  tasks[index].isCompleted = val;
                  controller.editTask(
                    updatedTask: tasks[index],
                  );
                },
              ),
            ),
          ),
          onLoading: Center(child: const CircularProgressIndicator()),
          onEmpty: Center(
            child: Text(
              LocaleKeys.noTasksFound.tr,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          onError: (error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                error!,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
