import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  final double _height = 50.0;

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
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('Latest Releases'),
              onTap: () {
                Get.offAllNamed('/releases');
              },
            ),
          ),
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('Distro Rankings'),
              onTap: () {
                Get.offAllNamed('/rankings');
              },
            ),
          ),
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('Latest Distros'),
              onTap: () {
                Get.offAllNamed('/newdistros');
              },
            ),
          ),
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('Latest Packages'),
              onTap: () {
                Get.offAllNamed('/packages');
              },
            ),
          ),
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('Latest Headlines'),
              onTap: () {
                Get.offAllNamed('/headlines');
              },
            ),
          ),
          // ListTile(
          //   title: const Text('Search Linux Distro'),
          //   onTap: () {
          //     Get.offAllNamed('/search');
          //   },
          // ),
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('Random Distro'),
              onTap: () {
                Get.offAllNamed('/random');
              },
            ),
          ),
          // ListTile(
          //   title: const Text('More Pages'),
          //   onTap: () {
          //     Get.offAllNamed('/more');
          //   },
          // ),
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('Settings'),
              onTap: () {
                // close the drawer
                Get.back();
                Get.toNamed('/settings');
              },
            ),
          ),
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('FAQ'),
              onTap: () {
                // close the drawer
                Get.back();
                Get.toNamed('/faq');
              },
            ),
          ),
          SizedBox(
            height: _height,
            child: ListTile(
              title: const Text('About'),
              onTap: () {
                // close the drawer
                Get.back();
                Get.toNamed('/about');
              },
            ),
          ),
        ],
      );
}
