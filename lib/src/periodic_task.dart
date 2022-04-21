import 'package:distro_watch_app/models/distro.dart';
import 'package:distro_watch_app/src/fetch.dart';
import 'package:distro_watch_app/src/notification.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/src/variables.dart';

Future<void> checkNewDistros() async {
  List<DistroModel> oldDistros = distros;
  String? response = await FetchData.getData();
  if (response != null) {
    parseData(response);
  }
  List<DistroModel> newDistros = distros
      .toSet()
      .difference(
        oldDistros.toSet(),
      )
      .toList();
  await pushNotification(newDistros.length);
}
