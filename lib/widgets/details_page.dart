import 'package:cached_network_image/cached_network_image.dart';
import 'package:distro_watch_app/models/distro.dart';
import 'package:distro_watch_app/src/fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget infoStyle({required String text, required String value}) => Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    DistroModel distro = Get.arguments as DistroModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          distro.title.substring(22),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            child: const Text(
              'OPTIONS',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              // TODO : Implement OPTIONS
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Container(
          color: Colors.black12,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: FutureBuilder<String?>(
            future: FetchData.getDistroDetails(section: distro.section),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://distrowatch.com/images/yvzhuwbpy/${distro.section}.png',
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://distrowatch.com/images/ktyxqzobhgijab/${distro.section}-small.png',
                                    fit: BoxFit.fitWidth,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.redAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              children: [
                                const Text(
                                  'General Information',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            infoStyle(
                                              text: 'Distro Name',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            infoStyle(
                                              text: 'Based on',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            infoStyle(
                                              text: 'Origin',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            infoStyle(
                                              text: 'Architecture',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                        child: Center(
                                          child: Container(
                                            width: 1,
                                            height: 100,
                                            color: Colors.black12,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            infoStyle(
                                              text: 'Desktop',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            infoStyle(
                                              text: 'Category',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            infoStyle(
                                              text: 'Status',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            infoStyle(
                                              text: 'Updated on',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.redAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Linux Distribution Information',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            infoStyle(
                                              text: 'Home Page',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            infoStyle(
                                              text: 'Documentation',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                        child: Center(
                                          child: Container(
                                            width: 1,
                                            height: 50,
                                            color: Colors.black12,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            infoStyle(
                                              text: 'Reddit',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            infoStyle(
                                              text: 'Download',
                                              value: distro
                                                  .section.capitalizeFirst!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // external links
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.web),
                              label: const Text('View on WebView'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.web),
                              label: const Text('View on WebView'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
