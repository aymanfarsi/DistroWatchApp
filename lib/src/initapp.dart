import 'package:distro_watch_app/src/periodic_task.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flavorbanner/flavorbanner.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:distro_watch_app/models/distro.dart';
import 'package:distro_watch_app/src/database.dart';
import 'package:distro_watch_app/src/variables.dart';
import 'package:distro_watch_app/src/fetch.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:workmanager/workmanager.dart';

Future<void> initApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // if (Platform.isAndroid) await AndroidAlarmManager.initialize();
  await initWorkManager();
  await initNotifications();
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
  await MyDatabase.openDB();
  await refreshDistros();
  await MyDatabase.closeDB();

  // FlutterNativeSplash
  FlutterNativeSplash.remove();
}

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'DS');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
}

void selectNotification(String? payload) async {
  FlutterAppBadger.removeBadge();
  debugPrint('notification payload: $payload');
  await Get.toNamed('/');
}

Future<void> refreshDistros() async {
  await MyDatabase.openDB();
  List<Map<String, Object?>> tempData = await MyDatabase.getAll();
  distros.clear();
  for (Map<String, Object?> item in tempData) {
    distros.add(
      DistroModel.fromJson(item),
    );
  }
  await MyDatabase.closeDB();
  String? response = await FetchData.getData();
  if (response != null) {
    await parseData(response);
  }
}

Future<void> initWorkManager() async {
  await Workmanager().initialize(
    checkNewDistros,
    isInDebugMode: true,
  );
  // setup periodic task to check for new distros
  await Workmanager().registerPeriodicTask(
    workmanagerUniqueName.toString(), // Each task must have an unique name.
    //This allows cancellation of a started task.
    'checkNewDistros', // will be send to your callbackDispatcher function, indicating the task's type
    initialDelay: const Duration(seconds: 5),
    frequency: const Duration(minutes: 15),
    tag: 'checkNewDistros',
    existingWorkPolicy: ExistingWorkPolicy.replace,
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
    backoffPolicy: BackoffPolicy.exponential,
  );
}
