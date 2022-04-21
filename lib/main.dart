import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:distro_watch_app/src/periodic_task.dart';
import 'package:distro_watch_app/src/variables.dart';
import 'package:flavorbanner/flavorbanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:distro_watch_app/src/initapp.dart';
import 'package:distro_watch_app/widgets/main_page.dart';
import 'package:distro_watch_app/widgets/settings_page.dart';
import 'package:distro_watch_app/widgets/welcome_page.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
  await AndroidAlarmManager.periodic(
    const Duration(hours: customAlarmInterval),
    customAlarmID,
    checkNewDistros,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DistroWatch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => FlavorBanner(
            child: MainPage(),
          ),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/settings',
          page: () => FlavorBanner(
            child: SettingsPage(),
          ),
          transitionDuration: const Duration(milliseconds: 500),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/welcome',
          page: () => const FlavorBanner(
            child: WelcomePage(),
          ),
          transition: Transition.fade,
        ),
      ],
      initialRoute: '/',
    );
  }
}
