import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/IworkoutLog_repository_API.dart';

abstract class WorkoutLogRepositoryAPI implements IWorkoutLogRepositoryAPI {
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
