import 'package:cached_network_image/cached_network_image.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/src/variables.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestDistros extends StatelessWidget {
  LatestDistros({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _fetchLatestnewDistros() async {
    await parseLatestDistros();
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
        title: const Text('Latest Linux Distributions'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _fetchLatestnewDistros();
              customSnackBar(
                title: "DistroWatch",
                description: "Latest newDistros refreshed",
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
            future: _fetchLatestnewDistros(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(9.0),
                child: Obx(
                  () => ListView.builder(
                    itemCount: newDistros.length,
                    padding: const EdgeInsets.only(bottom: 8.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 3,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: SizedBox(
                            width: 50,
                            child: (newDistros[index].title.contains('Weekly'))
                                ? const Icon(Icons.error)
                                : CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://distrowatch.com/images/yvzhuwbpy/${newDistros[index].section}.png',
                                    alignment: Alignment.center,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                  ),
                          ),
                          title: Text(
                            newDistros[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            newDistros[index].dayMonth,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(12.0),
                          onTap: () {
                            Get.toNamed(
                              '/details',
                              arguments: newDistros[index],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
