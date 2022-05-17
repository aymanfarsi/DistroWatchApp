import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:distro_watch_app/pubspec.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AboutPage(
      // scaffoldBuilder: (context, title, child) {
      //   return Scaffold(
      //     key: _scaffoldKey,
      //     drawer: const Drawer(child: CustomDrawer()),
      //     appBar: AppBar(
      //       leading: IconButton(
      //         icon: const Icon(Icons.menu),
      //         onPressed: () {
      //           _scaffoldKey.currentState!.openDrawer();
      //         },
      //       ),
      //       title: const Text('About'),
      //       centerTitle: false,
      //     ),
      //     body: const Center(
      //       child: Text('About'),
      //     ),
      //   );
      // },
      applicationName: 'DistroWatch App',
      values: {
        'version': Pubspec.version,
        'buildNumber': Pubspec.versionBuild.toString(),
        'year': DateTime.now().year.toString(),
        'author': Pubspec.authorsName,
      },
      title: const Text('About'),
      applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
      applicationDescription: const Text(
        Pubspec.description,
        textAlign: TextAlign.justify,
      ),
      applicationIcon: const FlutterLogo(size: 100),
      applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
      children: const <Widget>[
        // MarkdownPageListTile(
        //   filename: 'README.md',
        //   title: Text('View Readme'),
        //   icon: Icon(Icons.all_inclusive),
        // ),
        // MarkdownPageListTile(
        //   filename: 'CHANGELOG.md',
        //   title: Text('View Changelog'),
        //   icon: Icon(Icons.view_list),
        // ),
        // MarkdownPageListTile(
        //   filename: 'LICENSE.md',
        //   title: Text('View License'),
        //   icon: Icon(Icons.description),
        // ),
        // MarkdownPageListTile(
        //   filename: 'CONTRIBUTING.md',
        //   title: Text('Contributing'),
        //   icon: Icon(Icons.share),
        // ),
        // MarkdownPageListTile(
        //   filename: 'CODE_OF_CONDUCT.md',
        //   title: Text('Code of conduct'),
        //   icon: Icon(Icons.sentiment_satisfied),
        // ),
        LicensesPageListTile(
          title: Text('Open source Licenses'),
          icon: Icon(Icons.favorite),
        ),
      ],
    );
  }
}
