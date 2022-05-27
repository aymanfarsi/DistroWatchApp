import 'dart:io';

import 'package:distro_watch_app/src/notification.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

Future<void> updateApp() async {
  const String url =
      'https://github.com/AymanFARSI/DistroWatchApp/releases/latest/download/DistroWatchApp.apk';
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  String? taskId = await FlutterDownloader.enqueue(
    url: url,
    savedDir: tempPath,
    showNotification: true,
    openFileFromNotification: true,
  );
  if (taskId != null) {
    await pushNotification(taskId);
  }
}
