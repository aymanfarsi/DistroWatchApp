import 'package:distro_watch_app/src/variables.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

Future<void> pushNotification(String message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '0',
    'Notification Channel',
    channelDescription: 'Notification Channel Description',
    importance: Importance.defaultImportance,
    priority: Priority.high,
    ticker: 'ticker',
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    notificationID,
    message,
    null,
    platformChannelSpecifics,
  );
  FlutterAppBadger.updateBadgeCount(notificationID + 1);
  notificationID++;
}
