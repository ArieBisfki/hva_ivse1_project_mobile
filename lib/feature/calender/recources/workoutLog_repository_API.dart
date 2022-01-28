import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:ivse1_gymlife/common/http/data_reponse_E.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/common/util/logger_interceptor.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/IworkoutLog_repository_API.dart';

class WorkoutLogRepositoryAPI implements IWorkoutLogRepositoryAPI {
  static const String URL = "http://10.0.2.2:6060/workout-log";
  final storage = new FlutterSecureStorage();

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
                    "date": workout.date,
                    "exerciseLogs": workout.exerciseLogs,
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
        'authorization':
            'bearer ' + storage.read(key: 'refreshToken').toString(),
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()]).get(
        Uri.parse('$URL/'),
        headers: requestHeaders,
      );

      switch (response.statusCode) {
        case 200:
          var jsonResponse = jsonDecode(response.body);
          List<WorkoutLog> workouts = [];

          workouts = jsonResponse
              .map((item) => {
                    item.exerciseLogs = jsonResponse['workoutLogs'],
                    item.id = jsonResponse['workoutLogs'],
                    item.date = jsonResponse['workoutLogs'],
                  })
              .toList();

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

// TODO not implemented
  Future<Either<DataResponseE, DataResponse<int>>> deleteWorkout(
    WorkoutLog workout,
  ) async {
    if (workout.id == null) {
      if (workout.id!.isEven) {
        return await Right(DataResponse.loading("fake"));
      }
    }
    return Left(DataResponseE.INTERNAL_SERVER_ERROR);
  }

  Future<Either<DataResponseE, DataResponse<WorkoutLog>>> getWorkout(
    int id,
  ) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization':
            'bearer ' + storage.read(key: 'refreshToken').toString(),
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()]).get(
        Uri.parse('$URL/$id'),
        headers: requestHeaders,
      );

      switch (response.statusCode) {
        case 200:
          var jsonResponse = jsonDecode(response.body);
          WorkoutLog workout = jsonResponse;

          return Right(DataResponse.success(workout));
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
}
