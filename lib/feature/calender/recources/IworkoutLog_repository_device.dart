import 'package:either_dart/either.dart';
import 'package:ivse1_gymlife/common/http/data_reponse_E.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';

abstract class IWorkoutLogRepositoryDevice {
  Future<Either<DataResponseE, DataResponse<int>>> createWorkout(
    WorkoutLog workout,
  );

  Future<Either<DataResponseE, DataResponse<List<WorkoutLog>>>> getWorkouts();

  Future<Either<DataResponseE, DataResponse<int>>> deleteWorkout(
    WorkoutLog workout,
  );

  Future<Either<DataResponseE, DataResponse<WorkoutLog>>> getWorkout(
    int id,
  );
}
