import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_repository.dart';

part 'workout_event.dart';

part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final ExerciseLogRepository workoutRepository;

  WorkoutBloc({required this.workoutRepository}) : super(WorkoutInitial());

  WorkoutState get initialState => WorkoutInitial();

  List<ExerciseLog> _exercises = [];

  List<ExerciseLog> get exercises => _exercises;

  // void toggleExercise(Exercise exercise) {
  //   if (_exercises.contains(exercise)) {
  //     _exercises.remove(exercise);
  //   } else {
  //     _exercises.add(exercise);
  //   }
  // }

  @override
  Stream<WorkoutState> mapEventToState(
    WorkoutEvent event,
  ) async* {
    if (event is ResetExercise) {
      yield WorkoutInitial();
    }
    if (event is LoadExercisesEvent) {
      yield WorkoutDataState(StateLoading());

      final DataResponse<List<ExerciseLog>> result =
          await workoutRepository.getExercises(event.workoutLogId);

      if (result.data != null) {
        _exercises = result.data!;
      }

      switch (result.status) {
        case Status.Error:
          yield WorkoutDataState(StateError(result.message.toString()));
          break;
        case Status.Loading:
          yield WorkoutDataState(StateLoading());
          break;
        case Status.Success:
          if (result.data == null || result.data!.isEmpty) {
            yield WorkoutDataState(StateEmpty());
          } else {
            yield WorkoutDataState(StateSuccess(result));
          }
          break;
        default:
          print('Unknow state in ${toString()}: ${state.toString()}');
      }
    }
    if (event is GetExercisesEvent) {
      yield ExercisesLoadedState(_exercises);
    }
    if (event is NewExerciseEvent) {
      final DataResponse<dynamic> result =
          await workoutRepository.createExercise(event.exercise, event.workoutLogId);
      final DataResponse<List<ExerciseLog>> recall =
          await workoutRepository.getExercises(event.workoutLogId);

      if (recall.data != null) {
        _exercises = recall.data!;
      }

      switch (result.status) {
        case Status.Error:
          yield WorkoutDataState(StateError(result.message.toString()));
          break;
        case Status.Loading:
          yield WorkoutDataState(StateLoading());
          break;
        case Status.Success:
          yield WorkoutDataState(StateSuccess<Exercise>(result.data));
          break;
        default:
      }
    }
    if (event is DeleteExerciseEvent) {
      final DataResponse<dynamic> result =
          await workoutRepository.deleteExercises(event.exercise);

      _exercises.remove(event.exercise);

      switch (result.status) {
        case Status.Error:
          yield WorkoutDataState(StateError(result.message.toString()));
          break;
        case Status.Loading:
          yield WorkoutDataState(StateLoading());
          break;
        case Status.Success:
          yield WorkoutDataState(StateSuccess<Exercise>(result.data));
          break;
        default:
      }
    }
  }
}
