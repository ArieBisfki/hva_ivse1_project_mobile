import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';

/// @author Costa
/// Interface for the workout repo
abstract class IWorkoutRepository {
  Future<DataResponse<int>> createExercise(
    ExerciseLog exercise,
      int id
  );

  Future<DataResponse<List<ExerciseLog>>> getExercises(int id);

  Future<DataResponse<int>> deleteExercises(
    Exercise exercise,
  );

  Future<DataResponse<Exercise>> getExercise(
    int id,
  );
}
