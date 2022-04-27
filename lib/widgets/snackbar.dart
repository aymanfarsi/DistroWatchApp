import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar({
  required String title,
  required String description,
  required IconData icon,
}) =>
    Get.snackbar(
      title,
      description,
      icon: Icon(icon, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 25, 187, 216),
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
