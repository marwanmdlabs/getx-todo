import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/add_task/bindings/add_task_binding.dart';
import '../modules/add_task/views/add_task_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/task_details/bindings/task_details_binding.dart';
import '../modules/task_details/views/task_details_view.dart';
import '../modules/tasks_page/bindings/tasks_page_binding.dart';
import '../modules/tasks_page/views/tasks_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.ADD_TASK,
      page: () => const AddTaskView(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: _Paths.TASKS_PAGE,
      page: () => const TasksPageView(),
      binding: TasksPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.TASK_DETAILS,
      page: () => const TaskDetailsView(),
      binding: TaskDetailsBinding(),
    ),
  ];
}
