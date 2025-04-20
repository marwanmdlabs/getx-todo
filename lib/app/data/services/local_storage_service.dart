import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxService {
  late SharedPreferences sharedPref;

  @override
  void onInit() async {
    sharedPref = await SharedPreferences.getInstance();
    super.onInit();
  }

  void setBool({
    required String key,
    required bool value,
  }) async {
    await sharedPref.setBool(
      key,
      value,
    );
  }

  void getBool({
    required String key,
  }) async {
    sharedPref.getBool(
      key,
    );
  }
}
