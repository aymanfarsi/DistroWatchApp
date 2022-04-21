import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:distro_watch_app/src/variables.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(child: Text('DistroWatch')),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                //Get.offAllNamed('/');
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                //Get.offAllNamed('/about');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: const Text('DistroWatch'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: ListView.builder(
          itemCount: distros.length,
          padding: const EdgeInsets.only(bottom: 8.0),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                title: Text(
                  distros[index].title,
                ),
                subtitle: Text(
                  distros[index].description,
                ),
                contentPadding: const EdgeInsets.all(12.0),
                leading: CircleAvatar(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://distrowatch.com/images/yvzhuwbpy/${distros[index].section}.png',
                  ),
                ),
                onTap: () {
                  // Get.toNamed('/main/$index');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
