import 'package:get/get_connect/connect.dart';
import 'package:getx_todo_task/app/core/values/api_endpoints.dart';
import 'package:getx_todo_task/app/data/models/task_model.dart';

class TasksProvider extends GetConnect {
  Future<List<TaskModel>> getTasks() async {
    final List<TaskModel> tasksList = [];
    final response = await get(ApiEndpoints.tasksEndPoint);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }

    response.body.forEach((task) {
      tasksList.add(TaskModel.fromJson(task));
    });
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    return tasksList;
  }

  Future<TaskModel> addTask(TaskModel newTask) async {
    final response = await post(
      ApiEndpoints.tasksEndPoint,
      newTask.toJson(),
    );
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return newTask;
  }

  Future<TaskModel> editTask(TaskModel taskModel) async {
    final response = await put(
      "${ApiEndpoints.tasksEndPoint}/${taskModel.id}",
      taskModel.toJson(),
    );

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return taskModel;
  }

  Future<bool> deleteTask(String taskId) async {
    final response = await delete(
      "${ApiEndpoints.tasksEndPoint}/$taskId",
    );

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return true;
  }
}
