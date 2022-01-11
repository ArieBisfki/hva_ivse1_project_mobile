import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_db_adapter.dart';

import 'IworkoutLog_repository_device.dart';

class WorkoutLogRepositoryDevice implements IWorkoutLogRepositoryDevice {
  WorkoutLogRepositoryDevice({required this.dbAdapter});

  final WorkoutLogDbAdapter dbAdapter;

  @override
  Future<DataResponse<int>> createWorkout(
    WorkoutLog workout,
  ) async {
    try {
      // returns ID of last inserted row
      final int response = await dbAdapter.addWorkout(workout);

      if (response == 0) {
        return DataResponse<int>.connectivityError();
      }

      return DataResponse<int>.success(response);
    } catch (e) {
      return DataResponse<int>.error('Error', error: e);
    }
  }

  @override
  Future<DataResponse<List<WorkoutLog>>> getWorkouts() async {
    try {
      final Iterable<dynamic> response = await dbAdapter.getWorkouts();

      if (response.isEmpty) {
        return DataResponse<List<WorkoutLog>>.success([]);
      }

      final List<WorkoutLog> workouts =
          response.map((item) => item as WorkoutLog).toList();

      return DataResponse<List<WorkoutLog>>.success(workouts);
    } catch (e) {
      print(e);

      return DataResponse<List<WorkoutLog>>.error('Error', error: e);
    }
  }

  @override
  Future<DataResponse<int>> deleteWorkout(WorkoutLog workout) async {
    try {
      // returns rows affected, so nothing usable
      final int response = await dbAdapter.deleteWorkout(workout);

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
  Future<DataResponse<WorkoutLog>> getWorkout(int id) async {
    try {
      final dynamic response = await dbAdapter.getWorkout(id);

      if (response.isEmpty) {
        return DataResponse<WorkoutLog>.connectivityError();
      }

      final WorkoutLog workoutRes = response as WorkoutLog;

      return DataResponse<WorkoutLog>.success(workoutRes);
    } catch (e) {
      print(e);

      return DataResponse<WorkoutLog>.error('Error', error: e);
    }
  }
}
