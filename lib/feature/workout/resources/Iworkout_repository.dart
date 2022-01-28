import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';

abstract class IWorkoutRepository {
  Future<DataResponse<int>> createExercise(
    Exercise exercise,
  );

  Future<DataResponse<List<Exercise>>> getExercises();

  Future<DataResponse<int>> deleteExercises(
      Exercise exercise,
  );

  Future<DataResponse<Exercise>> getExercise(
    int id,
  );
}
