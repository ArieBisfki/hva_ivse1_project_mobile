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
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer ' + accessToken.toString(),
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()])
              .post(Uri.parse('$URL/'),
                  headers: requestHeaders,
                  body: jsonEncode({
                    "date": workout.date,
                    // "exerciseLogs": workout.exerciseLogs,
                    "exerciseLogs": [
                      {
                        "exercise": {"id": 1},
                        "sets": [
                          {"reps": 8, "weight": 101},
                          {"reps": 8, "weight": 100},
                          {"reps": 8, "weight": 100}
                        ]
                      }
                    ],
                  }));

      switch (response.statusCode) {
        case 200:
          var jsonResponse = jsonDecode(response.body);
          var workoutLog = WorkoutLog(
              exerciseLogs: jsonResponse["exerciseLogs"],
              id: jsonResponse["id"],
              date: jsonResponse["date"]);
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
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer ' + accessToken.toString(),
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()]).get(
        Uri.parse('$URL/'),
        headers: requestHeaders,
      );

      switch (response.statusCode) {
        case 200:
          var jsonResponse = jsonDecode(response.body);

          List<dynamic> logs = jsonResponse['workoutLogs'];
          List<WorkoutLog> workouts = [];

          if (logs.isEmpty) {
            // cant read/map an empty json list, so return an empty list
            return Right(DataResponse.success(workouts));
          }

          var logs2 = jsonResponse.map((e) => WorkoutLog.fromJson(e)).toList();

          workouts = logs2;

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
  ) async {
    try {
      int? id = workout.id;
      String? accessToken = await storage.read(key: 'accessToken');

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer ' + accessToken.toString(),
      };

      final response =
          await InterceptedHttp.build(interceptors: [LoggerInterceptor()])
              .delete(Uri.parse('$URL/$id'), headers: requestHeaders);

      switch (response.statusCode) {
        case 200:
          return Right(DataResponse.success(1));
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
