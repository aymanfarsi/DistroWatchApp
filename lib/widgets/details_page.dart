import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:distro_watch_app/widgets/custom_drawer.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required String distroName}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Text(Get.arguments.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              // TODO : Implement refreshDistroDetails()
            },
          ),
        ],
      ),
      body: Center(
        child: Text(Get.arguments.description),
      ),
    );
  }
}
