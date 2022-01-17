import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:ivse1_gymlife/common/http/data_reponse_E.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/common/util/logger_interceptor.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/IworkoutLog_repository_API.dart';

abstract class WorkoutLogRepositoryAPI implements IWorkoutLogRepositoryAPI {
  static const String URL = "http://10.0.2.2:6060/workout-log";

  Future<Either<DataResponseE, DataResponse<int>>> createWorkout(
    WorkoutLog workout,
  ) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()])
              .post(Uri.parse('$URL/'),
                  headers: requestHeaders,
                  body: jsonEncode({
                    "exerciseLogs": workout.exerciseLogs,
                    "date": workout.date,
                  }));

      switch (response.statusCode) {
        case 200:
          var jsonResponse = jsonDecode(response.body);
          var workoutLog =
              WorkoutLog(exerciseLogs: [], id: jsonResponse["id"], date: "");
          return Right(DataResponse.success(workoutLog.id));
        case 401:
          return Left(DataResponseE.INVALID_CREDENTIALS);
        case 500:
          return Left(DataResponseE.INTERNAL_SERVER_ERROR);
        default:
          return Left(DataResponseE.INTERNAL_SERVER_ERROR);
      }
    } catch (e) {
      return Left(DataResponseE.INTERNAL_SERVER_ERROR);
    }
  }

  Future<Either<DataResponseE, DataResponse<List<WorkoutLog>>>>
      getWorkouts() async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()]).get(
        Uri.parse('$URL/'),
        headers: requestHeaders,
      );

      switch (response.statusCode) {
        case 200:
          var jsonResponse = jsonDecode(response.body);

          if (jsonResponse) {
            return Right(DataResponse.success([]));
          }

          final List<WorkoutLog> workouts =
              jsonResponse.map((item) => item as WorkoutLog).toList();

          return Right(DataResponse.success(workouts));
        case 401:
          return Left(DataResponseE.INVALID_CREDENTIALS);
        case 500:
          return Left(DataResponseE.INTERNAL_SERVER_ERROR);
        default:
          return Left(DataResponseE.INTERNAL_SERVER_ERROR);
      }
    } catch (e) {
      return Left(DataResponseE.INTERNAL_SERVER_ERROR);
    }
  }

  Future<Either<DataResponseE, DataResponse<int>>> deleteWorkout(
    WorkoutLog workout,
  );

  Future<Either<DataResponseE, DataResponse<WorkoutLog>>> getWorkout(
    int id,
  );

  // TODO header bij calls
  // 'Authorization' : 'Bearer authtoken'
}
