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
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            curve: Curves.elasticInOut,
          ),
          ListTile(
            title: const Text('Latest Releases'),
            onTap: () {
              Get.offAllNamed('/releases');
            },
          ),
          ListTile(
            title: const Text('Latest Distros'),
            onTap: () {
              Get.offAllNamed('/distros');
            },
          ),
          ListTile(
            title: const Text('Latest Packages'),
            onTap: () {
              Get.offAllNamed('/packages');
            },
          ),
          ListTile(
            title: const Text('Latest Headlines'),
            onTap: () {
              Get.offAllNamed('/headlines');
            },
          ),
          ListTile(
            title: const Text('Search Linux Distro'),
            onTap: () {
              Get.offAllNamed('/search');
            },
          ),
          ListTile(
            title: const Text('Random Distro'),
            onTap: () {
              Get.offAllNamed('/random');
            },
          ),
          ListTile(
            title: const Text('More Pages'),
            onTap: () {
              Get.offAllNamed('/more');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Get.offAllNamed('/settings');
            },
          ),
          ListTile(
            title: const Text('FAQ'),
            onTap: () {
              Get.offAllNamed('/faq');
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Get.offAllNamed('/about');
            },
          ),
        ],
      );
}