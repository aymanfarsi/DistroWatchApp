import 'package:distro_watch_app/helpers/open_link.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/src/variables.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestHeadlines extends StatelessWidget {
  LatestHeadlines({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _fetchLatestHeadlines() async {
    await parseLatestHeadlines();
    customSnackBar(
      title: 'Success',
      description: 'Refreshed latest headlines',
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
        title: const Text('Latest Headlines'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _fetchLatestHeadlines();
              customSnackBar(
                title: "DistroWatch",
                description: "Latest headlines refreshed",
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
          future: _fetchLatestHeadlines(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(9.0),
              child: Obx(
                () => ListView.builder(
                  itemCount: headlines.length,
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
                          headlines[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              headlines[index]
                                  .pubDate
                                  .toString()
                                  .substring(0, 10)
                                  .replaceAll('-', '/'),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        onTap: () {
                          openLink(
                            link: headlines[index].guid,
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
