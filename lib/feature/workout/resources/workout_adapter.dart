import 'package:ivse1_gymlife/common/local_database/local_database.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseLogDbAdapter {
  Future<List<ExerciseData>> getExercises() async {
    final Database db = await LocalDatabase().db;
    final List<Map<String, Object?>> queryResult = await db.query('exercises');
    return queryResult.map((e) => ExerciseData.fromJson(e)).toList();
  }

  Future addExercise(ExerciseData ed) async {
    final Database db = await LocalDatabase().db;
    return db.insert('exercises', ed.toJson());
  }

  Future deleteExercise(ExerciseData ed) async {
    final Database db = await LocalDatabase().db;
    return db.delete('exercises', where: "id = ${ed.id}");
  }

  Future<ExerciseData> getExercise(int id) async {
    final Database db = await LocalDatabase().db;
    final ExerciseData queryResult =
    (await db.query("exercises", where: "id = $id")) as ExerciseData;
    return queryResult;
  }

// updateExercise(WorkoutLog workout) async { // TODO
//   final Database db = await LocalDatabase().db;
//    db.update("workouts", workout, where: "id = ${workout.id}");
// }
}
