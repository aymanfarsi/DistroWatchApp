import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:distro_watch_app/src/variables.dart';
import 'package:flavorbanner/flavorbanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:distro_watch_app/src/fetch.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:get/get.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
   await AndroidAlarmManager.initialize();
  FlavorConfig(
    flavor: Flavor.DEV,
    color: Colors.grey,
    values: FlavorValues(
      // baseUrl: "https://dev.com/",
      showBanner: true,
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await refreshDistros();
}

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
}

void selectNotification(String? payload) async {
  debugPrint('notification payload: $payload');
  await Get.toNamed('/');
}

Future<void> refreshDistros() async {
  String? response = await FetchData.getData();
  if (response != null) {
    parseData(response);
  }
}
