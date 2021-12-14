import 'package:ivse1_gymlife/common/local_database/local_database.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:sqflite/sqflite.dart';

class WorkoutLogDbAdapter {
  Future<List<WorkoutLog>> getWorkouts() async {
    final Database db = await LocalDatabase().db;
    final List<Map<String, Object?>> queryResult = await db.query('workouts');
    return queryResult.map((e) => WorkoutLog.fromJson(e)).toList();
  }

  Future addWorkout(WorkoutLog workout) async {
    final Database db = await LocalDatabase().db;
    db.insert('workouts', workout.toJson());
  }

  Future deleteWorkout(WorkoutLog workout) async {
    final Database db = await LocalDatabase().db;
    // TODO krijgt error op int? -> moet int worden
    db.delete('workouts', where: "id = ${workout.id}");
  }

  Future<WorkoutLog> getWorkout(int id) async {
    final Database db = await LocalDatabase().db;
    final WorkoutLog queryResult =
        (await db.query("workouts", where: "id = $id")) as WorkoutLog;
    return queryResult;
  }

  // updateWorkout(WorkoutLog workout) async { // TODO
  //   final Database db = await LocalDatabase().db;
  //    db.update("workouts", workout, where: "id = ${workout.id}");
  // }
}
