import 'package:cached_network_image/cached_network_image.dart';
import 'package:distro_watch_app/helpers/open_link.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/src/web_scrap.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class RandomDistro extends StatefulWidget {
  const RandomDistro({Key? key}) : super(key: key);

  @override
  State<RandomDistro> createState() => _RandomDistroState();
}

class _RandomDistroState extends State<RandomDistro> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();

  Widget infoStyle({
    required String text,
    required String value,
  }) {
    List<String> values = value.split(', ');
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Text(
                    values[index],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                itemCount: values.length,
              ),
            ),
          ),
        ],
      ),
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
        title: const Text('Random Linux Distro'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await parseRandomDistro();
              setState(() {});
              customSnackBar(
                title: "DistroWatch",
                description: "Refreshed Page",
                icon: Icons.person,
                duration: const Duration(seconds: 1),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<String?>(
        future: parseRandomDistro(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data == null
                ? const Center(
                    child: Text(
                      'Try again',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.black12,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: CustomWebScraper.getDistroDetails(
                          section: snapshot.data!),
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, dynamic>> snapshot2) {
                        if (snapshot2.connectionState == ConnectionState.done) {
                          if (snapshot2.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot2.error}',
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://distrowatch.com/images/yvzhuwbpy/${snapshot.data}.png',
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://distrowatch.com/images/ktyxqzobhgijab/${snapshot.data}-small.png',
                                              fit: BoxFit.fitWidth,
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: Text(
                                      'General Information',
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  infoStyle(
                                    text: 'Distro Name',
                                    value: snapshot2.data!['Distribution'] ??
                                        'null',
                                  ),
                                  infoStyle(
                                    text: 'Based on',
                                    value:
                                        snapshot2.data!['Based on'] ?? 'null',
                                  ),
                                  infoStyle(
                                    text: 'Origin',
                                    value: snapshot2.data!['Origin'] ?? 'null',
                                  ),
                                  infoStyle(
                                    text: 'Architecture',
                                    value: snapshot2.data!['architecture'] ??
                                        'null',
                                  ),
                                  infoStyle(
                                    text: 'Desktop',
                                    value: snapshot2.data!['Desktop'] ?? 'null',
                                  ),
                                  infoStyle(
                                    text: 'Category',
                                    value:
                                        snapshot2.data!['Category'] ?? 'null',
                                  ),
                                  infoStyle(
                                    text: 'Status',
                                    value: snapshot2.data!['Status'] ?? 'null',
                                  ),
                                  infoStyle(
                                    text: 'Updated on',
                                    value: snapshot2.data!['Last Update'] ??
                                        'null',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Linux Distribution Information',
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  infoStyle(
                                    text: 'Distribution',
                                    value: snapshot2.data!['Distribution'] ??
                                        'null',
                                  ),
                                  infoStyle(
                                    text: 'Home Page',
                                    value:
                                        snapshot2.data!['Home Page'] ?? 'null',
                                  ),
                                  infoStyle(
                                    text: 'Screenshots',
                                    value: snapshot2.data!['Screenshots'] ??
                                        'null',
                                  ),
                                  infoStyle(
                                    text: 'Download',
                                    value:
                                        snapshot2.data!['Downloads'] ?? 'null',
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        await openLink(
                                          link:
                                              'https://distrowatch.com/table.php?distribution=${snapshot.data}',
                                        );
                                      },
                                      icon: const Icon(Icons.web),
                                      label: const Text(
                                        'Linux Distro',
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
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
