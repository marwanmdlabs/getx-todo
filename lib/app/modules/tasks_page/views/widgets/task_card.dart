import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_todo_task/app/data/models/task_model.dart';
import 'package:getx_todo_task/app/routes/app_pages.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onToggle,
  });

  final TaskModel taskModel;
  final void Function(bool) onToggle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.TASK_DETAILS,
        arguments: taskModel,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              taskModel.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
                decoration:
                    taskModel.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            const Spacer(),
            Checkbox(
              value: taskModel.isCompleted,
              onChanged: (value) {
                onToggle(value ?? taskModel.isCompleted);
              },
            ),
          ],
        ),
      ),
    );
  }
}
