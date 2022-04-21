import 'package:distro_watch_app/src/fetch.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:flavorbanner/flavorbanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
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

Future<void> refreshDistros() async {
  String? response = await FetchData.getData();
  if (response != null) {
    parseData(response);
  }
}
