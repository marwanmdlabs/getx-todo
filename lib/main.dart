import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/theme.dart';
import 'package:getx_todo_task/app/core/values/localization/locales_controller.dart';
import 'package:getx_todo_task/app/core/values/local_storage_constants.dart';
import 'package:getx_todo_task/app/data/services/auth_service.dart';

import 'package:getx_todo_task/app/data/services/local_storage_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(
    MyApp(),
  );
}

Future<void> initServices() async {
  await Get.putAsync(() => LocalStorageService().init());
  await Get.putAsync(() => AuthService().init());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Locale initLocale =
      Locale(Get.find<LocalStorageService>().getLocaleCode());
  final bool isDarkTheme = Get.find<LocalStorageService>()
          .getBool(key: LocalStorageConstants.isDarkMode) ??
      false;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1000, 1000),
      builder: (context, child) => GetMaterialApp(
        title: "GETX TO-DO",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: isDarkTheme ? AppThemes.darkTheme : AppThemes.lightTheme,
        locale: initLocale,
        translations: AppTranslation(),
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
