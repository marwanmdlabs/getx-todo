import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void showCustomSnackBar(
      {required String title, String? message, bool isError = true}) {
    Get.snackbar(
      "",
      "",
      maxWidth: Get.width * 0.95,
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: message != null
          ? Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      margin: EdgeInsets.only(
        bottom: 12,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      backgroundColor: isError ? Get.theme.colorScheme.error : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        isError ? Icons.error_outline_rounded : Icons.check,
        color: Colors.white,
        size: 36,
      ),
    );
  }
}
