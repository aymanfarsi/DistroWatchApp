import 'dart:convert';
import 'package:xml2json/xml2json.dart';
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
      if (!distros.any((distro) => distro.url == item.url)) {
        newDistros.add(item);
      }
    }
  }
  if (newDistros.isNotEmpty) {
    distros.addAll(newDistros);
    await MyDatabase.openDB();
    for (DistroModel distro in newDistros.reversed) {
      distro.id = ++dbIDs;
      await MyDatabase.insertDB(distro);
    }
    await MyDatabase.closeDB();
  }
}
