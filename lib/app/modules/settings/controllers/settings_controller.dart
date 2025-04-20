import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/theme.dart';
// import 'package:shared_preferences.dart';

class SettingsController extends GetxController {
  // Theme
  final RxBool isDarkMode = false.obs;

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
    isDarkMode.value = false;
    currentLanguage.value = 'en';
  }

  Future<void> toggleTheme() async {
    isDarkMode.toggle();
    Get.changeTheme(
        isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme);
  }

  Future<void> changeLanguage(String langCode) async {
    currentLanguage.value = langCode;
    await Get.updateLocale(Locale(langCode));
  }

  void _updateThemeAndLanguage() {
    Get.changeTheme(
        isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme);
    Get.updateLocale(Locale(currentLanguage.value));
  }
}
