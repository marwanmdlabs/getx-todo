import 'package:get/get.dart';
import 'package:getx_todo_task/app/data/providers/tasks_provider.dart';

import '../controllers/tasks_page_controller.dart';

class TasksPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksController>(
      () => TasksController(),
    );
    Get.lazyPut<TasksProvider>(
      () => TasksProvider(),
    );
  }
}
