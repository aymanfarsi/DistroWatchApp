import 'package:distro_watch_app/models/distro.dart';
import 'package:sqflite/sqflite.dart';

import 'package:distro_watch_app/src/variables.dart';

class MyDatabase {
  MyDatabase();

  static Future<void> openDB() async {
    db = await openDatabase(
      dbName,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE $dbTable (id INTEGER PRIMARY KEY, title TEXT, url TEXT, description TEXT, section TEXT, date TEXT)',
        );
      },
      onOpen: (db) {
        db.rawQuery('SELECT * FROM $dbTable').then(
          (rows) {
            for (Map<String, dynamic> row in rows) {
              distros.add(DistroModel.fromJson(row));
            }
          },
        );
      },
    );
  }

  static Future<void> deleteDB() async {
    await db.delete(dbTable);
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    return await db.query(dbTable);
  }

  static Future<void> insertDB(DistroModel distro) async {
    await db.insert(
      dbTable,
      distro.toJson(),
    );
  }

  static Future<void> closeDB() async {
    await db.close();
  }
}
