import 'package:distro_watch_app/models/distro.dart';
import 'package:distro_watch_app/src/fetch.dart';
import 'package:distro_watch_app/src/notification.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:distro_watch_app/src/variables.dart';

Future<void> checkNewDistros() async {
  await pushNotification('Checking for new distros...');
  List<DistroModel> oldDistros = distros;
  String? response = await FetchData.getData();
  if (response != null) {
    parseData(response);
  }
  List<String> newUrls = distros
      .map(
        (item) => item.url,
      )
      .toSet()
      .difference(
        oldDistros
            .map(
              (item) => item.url,
            )
            .toSet(),
      )
      .toList();
  List<DistroModel> newDistros = distros
      .where(
        (item) => newUrls.contains(item.url),
      )
      .toList();
  await pushNotification(
    newDistros.length.toString(),
  );
}
