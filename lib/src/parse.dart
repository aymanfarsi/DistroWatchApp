import 'dart:convert';
import 'package:distro_watch_app/models/headline.dart';
import 'package:distro_watch_app/models/new_distro.dart';
import 'package:distro_watch_app/models/package.dart';
import 'package:intl/intl.dart';
import 'package:xml2json/xml2json.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:distro_watch_app/models/ranking.dart';
import 'package:distro_watch_app/models/ranktype.dart';
import 'package:distro_watch_app/src/fetch.dart';
import 'package:distro_watch_app/models/distro.dart';
import 'package:distro_watch_app/src/database.dart';
import 'package:distro_watch_app/src/variables.dart';

Future<void> parseData(String data) async {
  Xml2Json xml2json = Xml2Json();
  xml2json.parse(data);
  Map<String, dynamic> results = jsonDecode(xml2json.toGData());
  List<dynamic> items = results[r"rdf$RDF"]['item'];
  List<DistroModel> listItems = [];
  for (Map<String, dynamic> item in items) {
    listItems.add(
      DistroModel(
        id: int.parse(
          item['link'][r'$t'].split('/').last,
        ),
        title: item['title'][r'$t'],
        url: item['link'][r'$t'],
        description: item['description'][r'$t'],
        date: DateTime.parse(item[r'dc$date'][r'$t']),
        section: item[r'slash$section'][r'$t'],
      ),
    );
  }
  List<DistroModel> newDistros = [];
  if (listItems.isNotEmpty) {
    for (DistroModel item in listItems) {
      if (!distros.any(
        (distro) => distro.url == item.url,
      )) {
        newDistros.add(item);
      }
    }
  }
  if (newDistros.isNotEmpty) {
    distros.addAll(newDistros);
    await MyDatabase.openDB();
    for (DistroModel distro in newDistros.reversed) {
      await MyDatabase.insertDB(distro);
    }
    await MyDatabase.closeDB();
  }
}

Future<void> parseRankings(RankType rankType) async {
  List<dynamic>? results = await FetchData.getRankings();
  if (results != null) {
    results = results
        .where(
          (element) => element['dataSpanName'] == getType(type: rankType),
        )
        .toList();
    List<RankingModel> listItems = [];
    for (Map<String, dynamic> item in results.last['distributionsRanking']) {
      listItems.add(
        RankingModel.fromJson(item),
      );
    }
    rankings.value = listItems;
  }
}

Future<void> parseLatestDistros() async {
  String? data = await FetchData.getLatestDistros();
  if (data != null) {
    Xml2Json xml2json = Xml2Json();
    xml2json.parse(data);
    Map<String, dynamic> results = jsonDecode(xml2json.toGData());
    List<dynamic> items = results['rss']['channel']['item'];
    List<NewDistroModel> listItems = [];
    for (Map<String, dynamic> item in items) {
      listItems.add(
        NewDistroModel(
          title: item['title'][r'$t'].substring(
            item['title'][r'$t'].indexOf(' ') + 1,
          ),
          url: item['link'][r'$t'],
          section: item['link'][r'$t'].split('/').last,
          dayMonth: item['title'][r'$t'].split(' ').first,
        ),
      );
    }
    newDistros.value = listItems;
  } else {
    return;
  }
}

Future<String?> parseRandomDistro() async {
  String? html = await FetchData.getRandomDistro();
  if (html != null) {
    Document document = parse(html);
    try {
      String rssLink =
          document.querySelector("th.Invert > a")!.attributes['href']!;
      return rssLink.split('/').last.split('.').first;
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

Future<void> parseLatestPackages() async {
  String? data = await FetchData.getLatestPackages();
  if (data != null) {
    Xml2Json xml2json = Xml2Json();
    xml2json.parse(data);
    Map<String, dynamic> results = jsonDecode(xml2json.toGData());
    List<dynamic> items = results['rss']['channel']['item'];
    List<PackageModel> listItems = [];
    for (Map<String, dynamic> item in items) {
      listItems.add(
        PackageModel(
          title: item['title'][r'$t'].substring(
            item['title'][r'$t'].indexOf(' ') + 1,
          ),
          url: item['link'][r'$t'],
          description: item['description'][r'$t'],
          dayMonth: item['title'][r'$t'].split(' ').first,
        ),
      );
    }
    packages.value = listItems;
  } else {
    return;
  }
}

Future<void> parseLatestHeadlines() async {
  String? data = await FetchData.getLatestHeadlines();
  if (data != null) {
    Xml2Json xml2json = Xml2Json();
    xml2json.parse(data);
    Map<String, dynamic> results = jsonDecode(xml2json.toGData());
    List<dynamic> items = results['rss']['channel']['item'];
    List<HeadlineModel> listItems = [];
    for (Map<String, dynamic> item in items) {
      listItems.add(
        HeadlineModel(
          title: item['title'][r'$t'].trim(),
          link: item['link'][r'$t'].trim(),
          // 'EEE, d LLLL yyyy hh:mm:ss'
          pubDate: DateFormat(
            'EEE, d MMM yyyy hh:mm:ss',
          ).parse(
            item['pubDate'][r'$t'].trim(),
          ),
          guid: item[r'guid'][r'$t'].trim(),
        ),
      );
    }
    headlines.value = listItems;
  } else {
    return;
  }
}
