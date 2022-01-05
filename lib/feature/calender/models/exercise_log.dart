import 'exercise.dart';

class ExerciseLog {
  ExerciseLog({required this.exercise});
  Exercise exercise;

  ExerciseLog.fromJson(Map<String, dynamic> json)
      : exercise = Exercise.fromJson(json['exercise']);

  Map<String, dynamic> toJson() => {
        'exercise': exercise,
      };
}
