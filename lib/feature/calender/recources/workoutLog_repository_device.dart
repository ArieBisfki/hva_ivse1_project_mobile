import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_db_adapter.dart';

import 'IworkoutLog_repository_device.dart';

class WorkoutLogRepositoryDevice implements IWorkoutLogRepositoryDevice {
  WorkoutLogRepositoryDevice({required this.dbAdapter});

  final WorkoutLogDbAdapter dbAdapter;

  @override
  Future<DataResponse<WorkoutLog>> createWorkout(
    WorkoutLog workout,
  ) async {
    try {
      final dynamic response = await dbAdapter.addWorkout(workout);

      if (response == null) {
        return DataResponse<WorkoutLog>.connectivityError();
      }

      return DataResponse<WorkoutLog>.success(response);
    } catch (e) {
      return DataResponse<WorkoutLog>.error('Error', error: e);
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
}
