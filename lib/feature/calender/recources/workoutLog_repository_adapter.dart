import 'package:either_dart/either.dart';
import 'package:ivse1_gymlife/common/http/data_reponse_E.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_repository_API.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_repository_device.dart';

class WorkoutLogRepositoryAdapter {
  WorkoutLogRepositoryAdapter(this.apiRepo, this.deviceRepo);

  final WorkoutLogRepositoryAPI apiRepo;
  final WorkoutLogRepositoryDevice deviceRepo;

  bool isLoggedIn() {
    return true;
  }

  Future<Either<DataResponseE, DataResponse<int>>> createWorkout(
    WorkoutLog workout,
  ) async {
    if (isLoggedIn()) {
      return apiRepo.createWorkout(workout);
    } else {
      return deviceRepo.createWorkout(workout);
    }
  }

  Future<Either<DataResponseE, DataResponse<List<WorkoutLog>>>>
      getWorkouts() async {
    if (isLoggedIn()) {
      return apiRepo.getWorkouts();
    } else {
      return deviceRepo.getWorkouts();
    }
  }

  Future<Either<DataResponseE, DataResponse<int>>> deleteWorkout(
    WorkoutLog workout,
  ) async {
    if (isLoggedIn()) {
      return apiRepo.deleteWorkout(workout);
    } else {
      return deviceRepo.deleteWorkout(workout);
    }
  }

  Future<Either<DataResponseE, DataResponse<WorkoutLog>>> getWorkout(
    int id,
  ) async {
    if (isLoggedIn()) {
      return apiRepo.getWorkout(id);
    } else {
      return deviceRepo.getWorkout(id);
    }
  }
}
