import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';

abstract class IWorkoutRepository {
  Future<DataResponse<int>> createExercise(
    ExerciseData exercise,
  );

  Future<DataResponse<List<ExerciseData>>> getExercises();

  Future<DataResponse<int>> deleteExercises(
      ExerciseData exercise,
  );

  Future<DataResponse<ExerciseData>> getExercise(
    int id,
  );
}
