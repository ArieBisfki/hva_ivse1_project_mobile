part of 'workout_bloc.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();
}

class WorkoutInitial extends WorkoutState {
  @override
  List<Object> get props => [];
}

class WorkoutDataState extends WorkoutState {
  const WorkoutDataState(this.dataState);

  final DataState dataState;

  @override
  List<Object> get props => [dataState];
}

class ExercisesLoadedState extends WorkoutState {
  const ExercisesLoadedState(this.data);

  final List<ExerciseLog> data;

  @override
  List<Object> get props => [data];
}
