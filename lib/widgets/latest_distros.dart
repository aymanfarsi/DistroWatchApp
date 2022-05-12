import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class LatestDistros extends StatelessWidget {
  LatestDistros({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _fetchLatestDistros() async {
    dynamic results = await parseRandomDistro();
    customSnackBar(
      title: 'Success',
      description: 'Refreshed latest distributions',
      icon: Icons.check_circle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(child: CustomDrawer()),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: const Text('DistroWatch'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _fetchLatestDistros();
              customSnackBar(
                title: "DistroWatch",
                description: "List of Distros refreshed",
                icon: Icons.person,
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Latest Distros'),
      ),
    );
  }
}
