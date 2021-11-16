part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarInitial extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarDataState extends CalendarState {
  const CalendarDataState(this.dataState);

  final DataState dataState;

  @override
  List<Object> get props => [dataState];
}

class WorkoutsLoadedState extends CalendarState {
  const WorkoutsLoadedState(this.data);

  final List<WorkoutLog> data;

  @override
  List<Object> get props => [data];
}
