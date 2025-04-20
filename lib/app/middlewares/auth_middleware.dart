import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_task/app/data/services/auth_service.dart';
import 'package:getx_todo_task/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthService authService = Get.find<AuthService>();
    final bool isAuthenticated = authService.isAuthenticated;
    return isAuthenticated
        ? const RouteSettings(
            name: Routes.TASKS_PAGE,
          )
        : null;
  }
}
