import 'package:cached_network_image/cached_network_image.dart';
import 'package:distro_watch_app/helpers/open_link.dart';
import 'package:distro_watch_app/models/ranktype.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/src/variables.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Rankings extends StatefulWidget {
  const Rankings({Key? key}) : super(key: key);

  @override
  State<Rankings> createState() => _RankingsState();
}

class _RankingsState extends State<Rankings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();

  RankType _rankType = RankType.Last7days;

  _fetchRankings() async {
    await parseRankings(_rankType);
    customSnackBar(
      title: 'Success',
      description: 'Rankings updated based on ${getType(type: _rankType)}',
      icon: Icons.check_circle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: const Text('Latest Distributions'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchRankings,
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Center(
                child: DropdownButton(
                  menuMaxHeight: 300.0,
                  value: _rankType,
                  borderRadius: BorderRadius.circular(15),
                  // elevation: 0,
                  // underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: [
                    for (RankType rankType in RankType.values.reversed)
                      DropdownMenuItem(
                        value: rankType,
                        child: Text(
                          getType(type: rankType),
                        ),
                        alignment: Alignment.center,
                      ),
                  ],
                  onChanged: (value) async {
                    _rankType = value as RankType;
                    await _fetchRankings();
                  },
                ),
              ),
              FutureBuilder(
                future: _fetchRankings(),
                builder: (context, snapshot) => Obx(
                  () {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error fetching rankings'),
                      );
                    } else {
                      return ListView.builder(
                        itemBuilder: ((context, index) {
                          String section = rankings[index].url.split('/').last;
                          String imageUrl =
                              'https://distrowatch.com/images/yvzhuwbpy/$section.png';
                          return Card(
                            elevation: 3,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              leading: SizedBox(
                                width: 50,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: imageUrl,
                                  alignment: Alignment.center,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                              title: Text(rankings[index].name),
                              subtitle: Text(
                                'Rank => ${rankings[index].rank} \nValue => ${rankings[index].value}',
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () async {
                                await openLink(
                                  link: rankings[index].url,
                                );
                              },
                            ),
                          );
                        }),
                        itemCount: rankings.length,
                        shrinkWrap: true,
                        primary: false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
