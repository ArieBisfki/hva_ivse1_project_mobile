import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';

/// @author Costa
/// Interface for the workout repo
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
