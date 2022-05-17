import 'package:cached_network_image/cached_network_image.dart';
import 'package:distro_watch_app/helpers/open_link.dart';
import 'package:distro_watch_app/models/distro.dart';
import 'package:distro_watch_app/models/new_distro.dart';
import 'package:distro_watch_app/src/web_scrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
    bool isNewDistro = false;
    // ignore: prefer_typing_uninitialized_variables
    final distro;
    if (Get.arguments is DistroModel) {
      distro = Get.arguments as DistroModel;
    } else {
      distro = Get.arguments as NewDistroModel;
      isNewDistro = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewDistro ? distro.title : distro.title.substring(22),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () async {
              setState(() {});
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
          child: FutureBuilder<Map<String, dynamic>>(
            future: CustomWebScraper.getDistroDetails(section: distro.section),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
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
                          height: MediaQuery.of(context).size.height / 4,
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
                        if (!isNewDistro)
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Center(
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: distro.description,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  textAlign: TextAlign.justify,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
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
                          value: snapshot.data!['Distribution'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Based on',
                          value: snapshot.data!['Based on'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Origin',
                          value: snapshot.data!['Origin'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Architecture',
                          value: snapshot.data!['architecture'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Desktop',
                          value: snapshot.data!['Desktop'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Category',
                          value: snapshot.data!['Category'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Status',
                          value: snapshot.data!['Status'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Updated on',
                          value: snapshot.data!['Last Update'] ?? 'null',
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
                          value: snapshot.data!['Distribution'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Home Page',
                          value: snapshot.data!['Home Page'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Screenshots',
                          value: snapshot.data!['Screenshots'] ?? 'null',
                        ),
                        infoStyle(
                          text: 'Download',
                          value: snapshot.data!['Downloads'] ?? 'null',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // external links
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await openLink(
                                    link: distro.url,
                                  );
                                },
                                icon: const Icon(Icons.web),
                                label: const Text(
                                  'Releases Info',
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await openLink(
                                    link:
                                        'https://distrowatch.com/table.php?distribution=${distro.description}',
                                  );
                                },
                                icon: const Icon(Icons.web),
                                label: const Text(
                                  'Linux Distro',
                                ),
                                clipBehavior: Clip.hardEdge,
                              ),
                            ],
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
        ),
      ),
    );
  }
}
