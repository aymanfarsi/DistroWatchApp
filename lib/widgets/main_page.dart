import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:distro_watch_app/src/initapp.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/src/variables.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              await refreshDistros();
              Get.snackbar(
                "DistroWatch",
                "List of Distros refreshed",
                icon: const Icon(Icons.person, color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color.fromARGB(255, 25, 187, 216),
                borderRadius: 20,
                margin: const EdgeInsets.all(15),
                colorText: Colors.white,
                duration: const Duration(seconds: 4),
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal,
                forwardAnimationCurve: Curves.easeOutBack,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
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
                  leading: SizedBox(
                    width: 50,
                    child: (distros[index].title.contains('Weekly'))
                        ? const Icon(Icons.error)
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://distrowatch.com/images/yvzhuwbpy/${distros[index].section}.png',
                            alignment: Alignment.center,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                          ),
                  ),
                  title: Text(
                    distros[index].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text:
                          '${distros[index].description.substring(0, 125)}...',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                  onTap: () {
                    // Get.toNamed('/main/$index');
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
