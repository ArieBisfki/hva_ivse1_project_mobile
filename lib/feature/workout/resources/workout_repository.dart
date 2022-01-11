import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_adapter.dart';

import 'Iworkout_repository.dart';

class ExerciseLogRepository implements IWorkoutRepository {
  ExerciseLogRepository({required this.dbAdapter});

  final ExerciseLogDbAdapter dbAdapter;

  @override
  Future<DataResponse<int>> createExercise(ExerciseData exercise) async {
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
  Future<DataResponse<int>> deleteExercises(ExerciseData exercise) async {
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
  Future<DataResponse<List<ExerciseData>>> getExercises() async {
    try {
      final Iterable<dynamic> response = await dbAdapter.getExercises();

      if (response.isEmpty) {
        return DataResponse<List<ExerciseData>>.success([]);
      }

      final List<ExerciseData> exercises =
          response.map((item) => item as ExerciseData).toList();

      return DataResponse<List<ExerciseData>>.success(exercises);
    } catch (e) {
      print(e);

      return DataResponse<List<ExerciseData>>.error('Error', error: e);
    }
  }

  @override
  Future<DataResponse<ExerciseData>> getExercise(int id) async {
    try {
      final dynamic response = await dbAdapter.getExercise(id);

      if (response.isEmpty) {
        return DataResponse<ExerciseData>.connectivityError();
      }

      final ExerciseData exerciseRes = response as ExerciseData;

      return DataResponse<ExerciseData>.success(exerciseRes);
    } catch (e) {
      print(e);

      return DataResponse<ExerciseData>.error('Error', error: e);
    }
  }
}
