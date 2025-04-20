import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/values/local_storage_constants.dart';
import 'package:getx_todo_task/app/data/services/auth_service.dart';
import 'package:getx_todo_task/app/data/services/local_storage_service.dart';
import 'package:getx_todo_task/app/routes/app_pages.dart';
import 'package:getx_todo_task/gen/assets.gen.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(40),
          Image.asset(Assets.images.logo.path),
          const Gap(32),
          ElevatedButton(
            onPressed: () async {
              AuthService authService = Get.find<AuthService>();
              await authService.setUserToken("Dummy Token");
              Get.offNamed(Routes.TASKS_PAGE);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                Get.width * .85,
                50,
              ),
            ),
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}
