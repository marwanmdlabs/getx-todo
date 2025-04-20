import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_task/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    bool isAuthenticated = true;
    return isAuthenticated ? RouteSettings(name: Routes.TASKS_PAGE) : null;
  }
}
