import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class RandomDistro extends StatelessWidget {
  RandomDistro({Key? key}) : super(key: key);

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
              await parseRandomDistro();
              customSnackBar(
                title: "DistroWatch",
                description: "Refreshed Page",
                icon: Icons.person,
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: parseRandomDistro(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
