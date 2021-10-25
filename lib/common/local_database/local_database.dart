import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'gymlife.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE workouts()",
        );
      },
      version: 1,
    );
  }
}
