import 'package:distro_watch_app/src/initapp.dart';
import 'package:distro_watch_app/widgets/main_page.dart';
import 'package:distro_watch_app/widgets/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DistroWatch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/': (context) => MainPage(),
      },
      initialRoute: '/',
    );
  }
}
