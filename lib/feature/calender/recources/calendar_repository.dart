import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workout.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_api_provider.dart';

class CalendarRepository {
  CalendarRepository({required this.apiProvider});

  final CalendarApiProvider apiProvider;

  Future<DataResponse<Workout>> createWorkout(
    Workout workout,
  ) async {
    try {
      final dynamic response = await apiProvider.addWorkout(workout);

      if (response == null) {
        return DataResponse<Workout>.connectivityError();
      }

      return DataResponse<Workout>.success(response);
    } catch (e) {
      return DataResponse<Workout>.error('Error', error: e);
    }
  }

  getWorkouts() async {
    try {
      final Iterable<dynamic> response = await apiProvider.getWorkouts();

      if (response.isEmpty) {
        return DataResponse<List<Workout>>.connectivityError();
      }

      final List<Workout> workouts =
          response.map((dynamic item) => Workout.fromMap(item)).toList();

      return DataResponse<List<Workout>>.success(workouts);
    } catch (e) {
      return DataResponse<Workout>.error('Error', error: e);
    }
  }
}
