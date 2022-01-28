import 'dart:convert';

import 'package:ivse1_gymlife/common/local_database/local_database.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseLogDbAdapter {
  Future<List<Exercise>> getExercises(int id) async {
    final Database db = await LocalDatabase().db;
    final List<Map<String, Object?>> queryResult = await db.query('workouts',
        columns: ['exerciseLogs'], where: "id = $id");

    List a = List<dynamic>.from(queryResult[0].values).toList();

    return a.map((e) => Exercise.fromJson(e)).toList();
  }

  Future<List<WorkoutLog>> getWorkouts() async {
    final Database db = await LocalDatabase().db;
    final List<Map<String, Object?>> queryResult = await db.query('workouts');
    return queryResult.map((e) => WorkoutLog.fromJson(e)).toList();
  }

  Future<WorkoutLog> getWorkout(int id) async {
    final Database db = await LocalDatabase().db;
    final List<Map<String, dynamic>> queryResult =
        await db.query('workouts', where: "id = $id");

    // get first since there is only one outcome
    final WorkoutLog q = WorkoutLog.fromJson(queryResult.first);
    return q;
  }

  Future addExercise(ExerciseLog ed) async {
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
