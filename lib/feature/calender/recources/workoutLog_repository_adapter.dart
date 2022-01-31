import 'package:either_dart/either.dart';
import 'package:ivse1_gymlife/common/http/data_reponse_E.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_repository_API.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_repository_device.dart';
import 'package:ivse1_gymlife/feature/login/models/login_creds_response_E.dart';
import 'package:ivse1_gymlife/feature/login/models/login_response_S.dart';
import 'package:ivse1_gymlife/feature/login/recources/login_api.dart';

class WorkoutLogRepositoryAdapter {
  WorkoutLogRepositoryAdapter(this.apiRepo, this.deviceRepo, this.loginApi);

  final WorkoutLogRepositoryAPI apiRepo;
  final WorkoutLogRepositoryDevice deviceRepo;
  final LoginApi loginApi;

  Future<bool> isLoggedIn() async {
    final Either<LoginCredsResponseE, LoginResponseS> loginResponse =
        await loginApi.loginWithRefreshToken();
    if (loginApi.responseIsError(loginResponse)) {
      return false;
    }
    return true;
  }

  Future<Either<DataResponseE, DataResponse<int>>> createWorkout(
    WorkoutLog workout,
  ) async {
    if (await isLoggedIn()) {
      return apiRepo.createWorkout(workout);
    } else {
      return deviceRepo.createWorkout(workout);
    }
  }

  Future<Either<DataResponseE, DataResponse<List<WorkoutLog>>>> getWorkouts(
      bool loggedIn) async {
    if (await isLoggedIn() && loggedIn) {
      return apiRepo.getWorkouts();
    } else {
      return deviceRepo.getWorkouts();
    }
  }

  Future<Either<DataResponseE, DataResponse<int>>> deleteWorkout(
    WorkoutLog workout,
  ) async {
    if (await isLoggedIn()) {
      return apiRepo.deleteWorkout(workout);
    } else {
      return deviceRepo.deleteWorkout(workout);
    }
  }

  Future<Either<DataResponseE, DataResponse<WorkoutLog>>> getWorkout(
    int id,
  ) async {
    if (await isLoggedIn()) {
      return apiRepo.getWorkout(id);
    } else {
      return deviceRepo.getWorkout(id);
    }
  }
}
