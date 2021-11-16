import 'exercise_log.dart';

class WorkoutLog {
  WorkoutLog({
    required this.exerciseLog,
    required this.id,
    required this.date,
  });

  final int id;
  final List<ExerciseLog> exerciseLog;
  final DateTime date;

  WorkoutLog.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        exerciseLog = res["exerciseLog"],
        date = res["date"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'exerciseLog': exerciseLog,
      'date': date,
    };
  }
}
