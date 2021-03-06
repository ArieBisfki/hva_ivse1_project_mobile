import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  late Future<Database> db = () async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'gymlife.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, exerciseLogs TEXT, date TEXT)",
        );
      },
      version: 1,
    );
  }();
  static LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  LocalDatabase._internal();
}
