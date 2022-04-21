import 'package:distro_watch_app/src/fetch.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  String? response = await FetchData.getData();
  if (response != null) {
    parseData(response);
  } else {
    print('Error fetching data');
  }
}
