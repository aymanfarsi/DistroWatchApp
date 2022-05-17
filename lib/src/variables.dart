import 'package:distro_watch_app/models/distro.dart';
import 'package:distro_watch_app/models/new_distro.dart';
import 'package:distro_watch_app/models/ranking.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

// List of distros
RxList<DistroModel> distros = <DistroModel>[].obs;
RxList<NewDistroModel> newDistros = <NewDistroModel>[].obs;
RxList<RankingModel> rankings = <RankingModel>[].obs;

// Notifications
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Periodic background task
const int customAlarmID = 0;
const int customAlarmInterval = 2; // in hours

// Database
const String dbName = 'distrowatch.db';
const String dbTable = 'distros';
late Database db;

// Notification IDs
int notificationID = 0;

// Workmanager unique name
int workmanagerUniqueName = 0;
