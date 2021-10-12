import 'exercise_log.dart';

class Workout {
  Workout({
    required this.exerciseLog,
    required this.id,
    required this.date,
  });

  final int id;
  final ExerciseLog exerciseLog;
  final DateTime date;

  Workout.fromMap(Map<String, dynamic> res)
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
