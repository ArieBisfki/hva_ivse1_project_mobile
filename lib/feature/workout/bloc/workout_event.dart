part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();
}

class ResetExercise extends WorkoutEvent {
  List<Object> get props => [];
}

class GetExercisesEvent extends WorkoutEvent {
  const GetExercisesEvent();

  List<Object> get props => [];
}

class LoadExercisesEvent extends WorkoutEvent {
  const LoadExercisesEvent();

  List<Object> get props => [];
}

class NewExerciseEvent extends WorkoutEvent {
  const NewExerciseEvent(this.exercise);

  final Exercise exercise;

  List<Object> get props => [exercise];
}

class DeleteExerciseEvent extends WorkoutEvent {
  const DeleteExerciseEvent(this.exercise);

  final Exercise exercise;

  List<Object> get props => [exercise];
}
