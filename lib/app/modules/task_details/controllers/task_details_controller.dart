import 'package:get/get.dart';
import 'package:getx_todo_task/app/data/models/task_model.dart';

class TaskDetailsController extends GetxController {
  late TaskModel taskModel;

  @override
  void onInit() {
    super.onInit();
    taskModel = Get.arguments as TaskModel;
  }
}
