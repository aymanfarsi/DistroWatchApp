import 'package:distro_watch_app/helpers/open_link.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/src/variables.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestPackages extends StatelessWidget {
  LatestPackages({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _fetchLatestPackages() async {
    await parseLatestPackages();
    customSnackBar(
      title: 'Success',
      description: 'Refreshed latest packages',
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
        title: const Text('Latest Packages'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _fetchLatestPackages();
              customSnackBar(
                title: "DistroWatch",
                description: "Latest packages refreshed",
                icon: Icons.person,
              );
            },
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<void>(
          future: _fetchLatestPackages(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(9.0),
              child: Obx(
                () => ListView.builder(
                  itemCount: packages.length,
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
                          packages[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          packages[index].dayMonth,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            text: packages[index].description,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        onTap: () {
                          openLink(
                            link: packages[index].url,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
