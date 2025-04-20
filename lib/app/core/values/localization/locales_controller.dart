import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/values/localization/langs/ar.dart';
import 'package:getx_todo_task/app/core/values/localization/langs/en.dart';

class AppTranslation implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
      };
}
