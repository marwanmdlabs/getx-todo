import 'package:get/get.dart';
import 'package:getx_todo_task/app/modules/tasks_page/controllers/tasks_page_controller.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskDetailsController>(
      () => TaskDetailsController(),
    );
    Get.lazyPut<TasksController>(
      () => TasksController(),
    );
  }
}
