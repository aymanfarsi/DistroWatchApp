import 'package:distro_watch_app/models/distro.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

// List of distros
RxList<DistroModel> distros = <DistroModel>[].obs;

// Notifications
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Periodic background task
const int customAlarmID = 0;
const int customAlarmInterval = 1; // in hours

// Database
const String dbName = 'distrowatch.db';
const String dbTable = 'distros';
late Database db;
int dbIDs = 0;
