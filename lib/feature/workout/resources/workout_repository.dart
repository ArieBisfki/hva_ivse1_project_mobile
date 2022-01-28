import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_adapter.dart';

import 'Iworkout_repository.dart';

class ExerciseLogRepository implements IWorkoutRepository {
  ExerciseLogRepository({required this.dbAdapter});

  final ExerciseLogDbAdapter dbAdapter;

  @override
  Future<DataResponse<int>> createExercise(Exercise exercise) async {
    try {
      final int response = await dbAdapter.addExercise(exercise);

      if (response == 0) {
        return DataResponse<int>.connectivityError();
      }

      return DataResponse<int>.success(response);
    } catch (e) {
      return DataResponse<int>.error('Error', error: e);
    }
  }

  @override
  Future<DataResponse<int>> deleteExercises(Exercise exercise) async {
    try {
      final int response = await dbAdapter.deleteExercise(exercise);

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
  Future<DataResponse<List<Exercise>>> getExercises() async {
    try {
      final Iterable<dynamic> response = await dbAdapter.getExercises();

      if (response.isEmpty) {
        return DataResponse<List<Exercise>>.success([]);
      }

      final List<Exercise> exercises =
          response.map((item) => item as Exercise).toList();

      return DataResponse<List<Exercise>>.success(exercises);
    } catch (e) {
      print(e);

      return DataResponse<List<Exercise>>.error('Error', error: e);
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
