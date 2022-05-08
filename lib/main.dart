import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:distro_watch_app/src/periodic_task.dart';
import 'package:distro_watch_app/src/variables.dart';
import 'package:distro_watch_app/widgets/about.dart';
import 'package:distro_watch_app/widgets/details_page.dart';
import 'package:distro_watch_app/widgets/faq.dart';
import 'package:distro_watch_app/widgets/rankings.dart';
import 'package:distro_watch_app/widgets/latest_headlines.dart';
import 'package:distro_watch_app/widgets/latest_packages.dart';
import 'package:distro_watch_app/widgets/more_pages.dart';
import 'package:distro_watch_app/widgets/random_distro.dart';
import 'package:distro_watch_app/widgets/search_distro.dart';
import 'package:flavorbanner/flavorbanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:distro_watch_app/src/initapp.dart';
import 'package:distro_watch_app/widgets/latest_releases.dart';
import 'package:distro_watch_app/widgets/settings_page.dart';
import 'package:distro_watch_app/widgets/welcome_page.dart';

void main() async {
  await initApp();
  await AndroidAlarmManager.periodic(
    const Duration(
      hours: customAlarmInterval,
    ),
    customAlarmID,
    checkNewDistros,
  );
  runApp(
    const MyApp(),
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
          name: '/welcome',
          page: () => const WelcomePage(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/releases',
          page: () => LatestReleases(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/details',
          page: () => const DetailsPage(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/rankings',
          page: () => const Rankings(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/packages',
          page: () => const LatestPackages(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/headlines',
          page: () => const LatestHeadlines(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/search',
          page: () => const SearchDistro(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/random',
          page: () => const RandomDistro(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/more',
          page: () => const MorePages(),
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
          name: '/faq',
          page: () => const FAQ(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/about',
          page: () => const About(),
          transition: Transition.fade,
        ),
      ],
      initialRoute: '/releases',
    );
  }
}
