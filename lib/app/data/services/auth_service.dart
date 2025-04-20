import 'package:get/get.dart';
import 'package:getx_todo_task/app/data/services/local_storage_service.dart';

class AuthService extends GetxService {
  LocalStorageService localStorageService = Get.find<LocalStorageService>();
  final RxBool _isAuthenticated = false.obs;

  bool get isAuthenticated => _isAuthenticated.value;
  Future<AuthService> init() async {
    _isAuthenticated.value = await localStorageService.isAuthenticated();
    return this;
  }

  Future<void> setUserToken(String value) async {
    if (value.trim().isNotEmpty) {
      await localStorageService.setUserToken(value);
      _isAuthenticated.value = true;
    }
  }

  Future<void> clearUserToken() async {
    await localStorageService.clearToken();
    _isAuthenticated.value = false;
  }
}
