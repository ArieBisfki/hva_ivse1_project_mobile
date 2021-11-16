import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_db_adapter.dart';

abstract class ICalendarRepositoryDevice {
  Future<DataResponse<WorkoutLog>> createWorkout(
    WorkoutLog workout,
  );
  Future<DataResponse<List<WorkoutLog>>> getWorkouts();
}
