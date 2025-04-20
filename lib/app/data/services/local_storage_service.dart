import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/values/local_storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService extends GetxService {
  late final SharedPreferences sharedPref;
  late final FlutterSecureStorage secureStorage;

  Future<LocalStorageService> init() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    secureStorage = FlutterSecureStorage(aOptions: getAndroidOptions());
    sharedPref = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> setUserToken(String token) async {
    await secureStorage.write(
        key: LocalStorageConstants.userToken, value: token);
  }

  Future<void> clearToken() async {
    await secureStorage.delete(
      key: LocalStorageConstants.userToken,
    );
  }

  Future<String?> getUserToken() async {
    final String? token =
        await secureStorage.read(key: LocalStorageConstants.userToken);
    return token;
  }

  Future<bool> isAuthenticated() async {
    final String? token = await getUserToken();
    return token != null && token.trim().isNotEmpty;
  }

  Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    await sharedPref.setBool(
      key,
      value,
    );
  }

  bool? getBool({
    required String key,
  }) {
    final bool? val = sharedPref.getBool(
      key,
    );
    return val;
  }

  Future<void> setString({
    required String key,
    required String value,
  }) async {
    await sharedPref.setString(
      key,
      value,
    );
  }

  String? getString({
    required String key,
  }) {
    final String? val = sharedPref.getString(
      key,
    );
    return val;
  }

  String getLocaleCode() {
    return sharedPref.getString(LocalStorageConstants.localeCode) ?? 'en';
  }
}
