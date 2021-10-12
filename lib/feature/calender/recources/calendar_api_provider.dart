import 'package:ivse1_gymlife/common/local_database/local_database.dart';
import 'package:ivse1_gymlife/feature/calender/models/workout.dart';
import 'package:sqflite/sqflite.dart';

class CalendarApiProvider {
  Future<List<Workout>> getWorkouts() async {
    final Database db = await LocalDatabase().initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => Workout.fromMap(e)).toList();
  }

  // Future<Workout> getWorkout(int id) async {
  //   final Database db = await LocalDatabase().initializeDB();
  //   final Workout queryResult = await db.query(table);
  //   return queryResult;
  // }

  Future addWorkout(Workout workout) async {
    final Database db = await LocalDatabase().initializeDB();
    db.insert('workout', workout.toMap as Map<String, dynamic>);
  }
}
