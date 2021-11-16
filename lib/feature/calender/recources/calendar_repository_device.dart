import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_db_adapter.dart';

import 'Icalendar_repository_device.dart';

class CalendarRepositoryDevice implements ICalendarRepositoryDevice {
  CalendarRepositoryDevice({required this.dbAdapter});

  final CalendarDbAdapter dbAdapter;

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
          response.map((dynamic item) => WorkoutLog.fromMap(item)).toList();

      return DataResponse<List<WorkoutLog>>.success(workouts);
    } catch (e) {
      return DataResponse<List<WorkoutLog>>.error('Error', error: e);
    }
  }
}
