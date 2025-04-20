import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:getx_todo_task/app/core/values/localization/locales_keys.dart';
import 'package:getx_todo_task/app/data/services/auth_service.dart';
import 'package:getx_todo_task/app/routes/app_pages.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          LocaleKeys.settings.tr,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Theme Switcher
            Obx(() => _buildSettingItem(
                  icon: Icons.brightness_6,
                  title: LocaleKeys.darkMode.tr,
                  trailing: Switch(
                    value: controller.isDarkMode.value,
                    onChanged: (value) => controller.toggleTheme(),
                  ),
                )),

            const Divider(),

            // Language Switcher
            Obx(
              () => _buildSettingItem(
                icon: Icons.language,
                title: LocaleKeys.language.tr,
                trailing: DropdownButton<String>(
                  value: controller.currentLanguage.value,
                  items: controller.languages.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) controller.changeLanguage(value);
                  },
                ),
              ),
            ),
            const Divider(),
            const Gap(16),
            ElevatedButton(
              onPressed: () async {
                AuthService authService = Get.find<AuthService>();
                await authService.clearUserToken();

                Get.offNamed(Routes.LOGIN);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  Get.width * .55,
                  50,
                ),
              ),
              child: Text(
                LocaleKeys.logout.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
    );
  }
}
