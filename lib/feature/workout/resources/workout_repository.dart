import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_adapter.dart';

import 'Iworkout_repository.dart';

class ExerciseLogRepository implements IWorkoutRepository {
  ExerciseLogRepository({required this.dbAdapter});

  final ExerciseLogDbAdapter dbAdapter;

  @override
  Future<DataResponse<int>> createExercise(
      ExerciseLog exerciseLog, int? id) async {
    try {
      final WorkoutLog request = await dbAdapter.getWorkout(id!);
      request.exerciseLogs.add(exerciseLog);

      final int response = await dbAdapter.addExercise(request);

      if (response == 0) {
        return DataResponse<int>.connectivityError();
      }

      return DataResponse<int>.success(response);
    } catch (e) {
      return DataResponse<int>.error('Error', error: e);
    }
  }

  @override
  Future<DataResponse<int>> deleteExercises(
      ExerciseLog exercise, int? id) async {
    try {
      final WorkoutLog request = await dbAdapter.getWorkout(id!);
      request.exerciseLogs.remove(exercise);
      //
      // final Exercise request = await dbAdapter.getExercise(exercise.id!);
      final int response = await dbAdapter.deleteExercise(request);

      if (response == 0) {
        return DataResponse<int>.connectivityError();
      }

      return DataResponse<int>.success(response);
    } catch (e) {
      print(e);

      return DataResponse<int>.error('Error', error: e);
    }
  }

  @override
  Future<DataResponse<List<ExerciseLog>>> getExercises(int id) async {
    try {
      final WorkoutLog response = await dbAdapter.getWorkout(id);

      final List<ExerciseLog> exercises = response.exerciseLogs;

      return DataResponse<List<ExerciseLog>>.success(exercises);
    } catch (e) {
      print(e);

      return DataResponse<List<ExerciseLog>>.error('Error', error: e);
    }
  }

  @override
  Future<DataResponse<Exercise>> getExercise(int id) async {
    try {
      final dynamic response = await dbAdapter.getExercise(id);

      if (response.isEmpty) {
        return DataResponse<Exercise>.connectivityError();
      }

      final Exercise exerciseRes = response as Exercise;

      return DataResponse<Exercise>.success(exerciseRes);
    } catch (e) {
      print(e);

      return DataResponse<Exercise>.error('Error', error: e);
    }
  }
}
