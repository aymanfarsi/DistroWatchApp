import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openLink({required String link}) async {
  Get.defaultDialog(
    title: 'Opening Link',
    content: RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text:
                'You will be redirected to the link outside the app. Do you want to continue?\n\n',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: link,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    ),
    actions: [
      ElevatedButton(
        child: const Text('Cancel'),
        onPressed: () => Get.back(),
      ),
      ElevatedButton(
        child: const Text('Open'),
        onPressed: () async {
          Get.back();
          if (!await launchUrl(
            Uri.parse(link),
            mode: LaunchMode.externalApplication,
          )) debugPrint('Could not launch $link');
        },
      ),
    ],
    barrierDismissible: true,
  );
}
