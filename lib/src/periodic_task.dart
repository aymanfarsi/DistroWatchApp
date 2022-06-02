import 'package:distro_watch_app/models/distro.dart';
import 'package:distro_watch_app/src/fetch.dart';
import 'package:distro_watch_app/src/notification.dart';
import 'package:distro_watch_app/src/parse.dart';
import 'package:workmanager/workmanager.dart';

Future<void> checkNewDistros() async {
  Workmanager().executeTask(
    (task, inputData) async {
      // await pushNotification('Checking for new distros...');
      String? response = await FetchData.getData();
      if (response != null) {
        List<DistroModel>? newreleases = await parseData(response);
        if (newreleases != null) {
          return Future.value(true);
        }
        if (newreleases!.isNotEmpty) {
          await pushNotification(
            '${newreleases.length} New Linux Distros 😎',
          );
        }
        return Future.value(true);
      }
      return Future.value(true);
    },
  );
}
