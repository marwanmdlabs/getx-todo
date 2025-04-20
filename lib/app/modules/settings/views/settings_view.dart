import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Theme Switcher
            Obx(() => _buildSettingItem(
                  icon: Icons.brightness_6,
                  title: 'theme'.tr,
                  trailing: Switch(
                    value: controller.isDarkMode.value,
                    onChanged: (value) => controller.toggleTheme(),
                  ),
                )),

            const Divider(),

            // Language Switcher
            Obx(() => _buildSettingItem(
                  icon: Icons.language,
                  title: 'language'.tr,
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
                )),
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
