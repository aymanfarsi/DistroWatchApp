import 'package:distro_watch_app/widgets/latest_distros.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:distro_watch_app/widgets/about.dart';
import 'package:distro_watch_app/widgets/details_page.dart';
import 'package:distro_watch_app/widgets/faq.dart';
import 'package:distro_watch_app/widgets/rankings.dart';
import 'package:distro_watch_app/widgets/latest_headlines.dart';
import 'package:distro_watch_app/widgets/latest_packages.dart';
import 'package:distro_watch_app/widgets/random_distro.dart';
import 'package:distro_watch_app/src/initapp.dart';
import 'package:distro_watch_app/widgets/latest_releases.dart';
import 'package:distro_watch_app/widgets/settings_page.dart';
import 'package:distro_watch_app/widgets/welcome_page.dart';

void main() async {
  await initApp();
  /* await AndroidAlarmManager.periodic(
    const Duration(
      minutes: customAlarmInterval,
    ),
    customAlarmID,
    checkNewDistros,
    rescheduleOnReboot: true,
  ); */
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
          name: '/newdistros',
          page: () => LatestDistros(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/packages',
          page: () => LatestPackages(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/headlines',
          page: () => LatestHeadlines(),
          transition: Transition.fade,
        ),
        // GetPage(
        //   name: '/search',
        //   page: () => const SearchDistro(),
        //   transition: Transition.fade,
        // ),
        GetPage(
          name: '/random',
          page: () => const RandomDistro(),
          transition: Transition.fade,
        ),
        // GetPage(
        //   name: '/more',
        //   page: () => const MorePages(),
        //   transition: Transition.fade,
        // ),
        GetPage(
          name: '/settings',
          page: () => SettingsPage(), // removed FlavorBanner
          transitionDuration: const Duration(milliseconds: 500),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/faq',
          page: () => FAQ(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/about',
          page: () => About(),
          transition: Transition.fade,
        ),
      ],
      initialRoute: '/releases',
    );
  }
}
