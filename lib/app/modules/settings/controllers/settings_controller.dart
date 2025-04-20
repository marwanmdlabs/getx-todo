import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/theme.dart';
import 'package:getx_todo_task/app/core/values/local_storage_constants.dart';
import 'package:getx_todo_task/app/data/services/local_storage_service.dart';
// import 'package:shared_preferences.dart';

class SettingsController extends GetxController {
  // Theme
  final RxBool isDarkMode = false.obs;
  LocalStorageService localStorageService = Get.find<LocalStorageService>();

  // Language
  final RxString currentLanguage = 'en'.obs;
  final Map<String, String> languages = {
    'en': 'English',
    'ar': 'العربية',
  };

  @override
  void onInit() {
    _loadSettings();
    super.onInit();
  }

  Future<void> _loadSettings() async {
    isDarkMode.value = localStorageService.getBool(
          key: LocalStorageConstants.isDarkMode,
        ) ??
        false;
    currentLanguage.value = localStorageService.getLocaleCode();
  }

  Future<void> toggleTheme() async {
    isDarkMode.toggle();
    localStorageService.setBool(
      key: LocalStorageConstants.isDarkMode,
      value: isDarkMode.value,
    );
    Get.changeTheme(
        isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme);
  }

  Future<void> changeLanguage(String langCode) async {
    currentLanguage.value = langCode;
    localStorageService.setString(
      key: LocalStorageConstants.localeCode,
      value: langCode,
    );
    await Get.updateLocale(Locale(langCode));
  }

  void _updateThemeAndLanguage() {
    Get.changeTheme(
        isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme);
    Get.updateLocale(Locale(currentLanguage.value));
  }
}
