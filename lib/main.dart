import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/theme.dart';
import 'package:getx_todo_task/app/core/values/localization/locales_controller.dart';

import 'package:getx_todo_task/app/data/services/local_storage_service.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  runApp(
    MyApp(),
  );
}

void initServices() {
  Get.put(LocalStorageService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1000, 1000),
      builder: (context, child) => GetMaterialApp(
        title: "GETX TO-DO",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: AppThemes.lightTheme,
        locale: Locale("en"),
        translations: AppTranslation(),
        defaultTransition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
