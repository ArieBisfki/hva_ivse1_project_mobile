import 'package:ivse1_gymlife/common/local_database/local_database.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseLogDbAdapter {
  Future<List<Exercise>> getExercises() async {
    final Database db = await LocalDatabase().db;
    final List<Map<String, Object?>> queryResult = await db.query('workouts');
    return queryResult.map((e) => Exercise.fromJson(e)).toList();
  }

  Future addExercise(Exercise ed) async {
    final Database db = await LocalDatabase().db;
    return db.insert('workouts', ed.toJson());
  }

  Future deleteExercise(Exercise ed) async {
    final Database db = await LocalDatabase().db;
    return db.delete('workouts', where: "id = ${ed.id}");
  }

  // Future updateExercise(Exercise ed) async { // TODO
  //   final Database db = await LocalDatabase().db;
  //   return db.update('exercises', where: "id = ${ed.id}");
  // }

  Future<Exercise> getExercise(int id) async {
    final Database db = await LocalDatabase().db;
    final Exercise queryResult =
    (await db.query("workouts", where: "id = $id")) as Exercise;
    return queryResult;
  }


}
