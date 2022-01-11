import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';

abstract class IWorkoutLogRepositoryDevice {
  Future<DataResponse<int>> createWorkout(
    WorkoutLog workout,
  );

  Future<DataResponse<List<WorkoutLog>>> getWorkouts();

  Future<DataResponse<int>> deleteWorkout(
    WorkoutLog workout,
  );

  Future<DataResponse<WorkoutLog>> getWorkout(
    int id,
  );
}
