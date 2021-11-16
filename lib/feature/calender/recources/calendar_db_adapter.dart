import 'package:ivse1_gymlife/common/local_database/local_database.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:sqflite/sqflite.dart';

class CalendarDbAdapter {
  Future<List<WorkoutLog>> getWorkouts() async {
    final Database db = await LocalDatabase().initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('workouts');
    return queryResult.map((e) => WorkoutLog.fromMap(e)).toList();
  }

  // Future<Workout> getWorkout(int id) async { // TODO
  //   final Database db = await LocalDatabase().initializeDB();
  //   final Workout queryResult = await db.query(table);
  //   return queryResult;
  // }

  Future addWorkout(WorkoutLog workout) async {
    final Database db = await LocalDatabase().initializeDB();
    db.insert('workout', workout.toMap as Map<String, dynamic>);
  }
}
