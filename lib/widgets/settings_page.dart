import 'package:distro_watch_app/src/database.dart';
import 'package:distro_watch_app/src/notification.dart';
import 'package:distro_watch_app/widgets/custom_drawer.dart';
import 'package:distro_watch_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: SettingsList(
        shrinkWrap: true,
        sections: [
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: const Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.format_paint),
                title: const Text('Enable custom theme'),
              ),
              SettingsTile(
                title: const Text('Delete Database'),
                onPressed: (BuildContext ctx) async {
                  await MyDatabase.openDB();
                  List<Map<String, Object?>> tempData =
                      await MyDatabase.getAll();
                  await MyDatabase.deleteDB();
                  await MyDatabase.closeDB();
                  customSnackBar(
                    title: 'Settings',
                    description: '${tempData.length} entries were deleted',
                    icon: Icons.local_fire_department,
                  );
                },
              ),
              SettingsTile(
                title: const Text('Test Notifications'),
                onPressed: (BuildContext ctx) async {
                  await pushNotification(
                    '23',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
