import 'package:either_dart/either.dart';
import 'package:ivse1_gymlife/common/http/data_reponse_E.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_db_adapter.dart';

import 'IworkoutLog_repository_device.dart';

class WorkoutLogRepositoryDevice implements IWorkoutLogRepositoryDevice {
  WorkoutLogRepositoryDevice({required this.dbAdapter});

  final WorkoutLogDbAdapter dbAdapter;

  @override
  Future<Either<DataResponseE, DataResponse<int>>> createWorkout(
    WorkoutLog workout,
  ) async {
    try {
      // returns ID of last inserted row
      final int response = await dbAdapter.addWorkout(workout);

      if (response == 0) {
        Left(DataResponseE.INTERNAL_SERVER_ERROR);
      }

      return Right(DataResponse<int>.success(response));
    } catch (e) {
      return Left(DataResponseE.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<Either<DataResponseE, DataResponse<List<WorkoutLog>>>>
      getWorkouts() async {
    try {
      final Iterable<dynamic> response = await dbAdapter.getWorkouts();

      if (response.isEmpty) {
        return Right(DataResponse<List<WorkoutLog>>.success([]));
      }

      final List<WorkoutLog> workouts =
          response.map((item) => item as WorkoutLog).toList();

      return Right(DataResponse<List<WorkoutLog>>.success(workouts));
    } catch (e) {
      print(e);

      return Left(DataResponseE.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<Either<DataResponseE, DataResponse<int>>> deleteWorkout(
      WorkoutLog workout) async {
    try {
      // returns rows affected, so nothing usable
      final int response = await dbAdapter.deleteWorkout(workout);

      if (response == 0) {
        return Left(DataResponseE.INTERNAL_SERVER_ERROR);
      }

      return Right(DataResponse<int>.success(response));
    } catch (e) {
      print(e);

      return Left(DataResponseE.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<Either<DataResponseE, DataResponse<WorkoutLog>>> getWorkout(
      int id) async {
    try {
      final dynamic response = await dbAdapter.getWorkout(id);

      if (response.isEmpty) {
        return Left(DataResponseE.INTERNAL_SERVER_ERROR);
      }

      final WorkoutLog workoutResponse = response as WorkoutLog;

      return Right(DataResponse<WorkoutLog>.success(workoutResponse));
    } catch (e) {
      print(e);

      return Left(DataResponseE.INTERNAL_SERVER_ERROR);
    }
  }
}
