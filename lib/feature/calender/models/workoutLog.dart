import 'dart:convert';

import 'exercise_log.dart';

class WorkoutLog {
  WorkoutLog({
    required this.exerciseLogs,
    required this.id,
    required this.date,
  });

  final int? id;
  final List<ExerciseLog> exerciseLogs;
  final String date;

  WorkoutLog.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        exerciseLogs = (jsonDecode(json['exerciseLogs']) as List)
            .map((exerciseLog) => ExerciseLog.fromJson(exerciseLog))
            .toList(),
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'exerciseLogs': jsonEncode(exerciseLogs),
        'date': date,
      };
}
