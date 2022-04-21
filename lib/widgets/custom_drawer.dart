import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          DrawerHeader(
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              imageUrl: 'https://distrowatch.com/images/cpxtu/dwbanner.png',
              alignment: Alignment.center,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            curve: Curves.elasticInOut,
          ),
          ListTile(
            title: const Text('Main Page'),
            onTap: () {
              Get.offAllNamed('/');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Get.offAllNamed('/settings');
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              //Get.offAllNamed('/about');
            },
          ),
        ],
      );
}
