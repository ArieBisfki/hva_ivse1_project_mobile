part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class GetCalendarEvent extends CalendarEvent {
  List<Object> get props => [];
}

class ResetCalendar extends CalendarEvent {
  List<Object> get props => [];
}

class GetWorkoutsEvent extends CalendarEvent {
  const GetWorkoutsEvent();

  List<Object> get props => [];
}

class NewCalendarEvent extends CalendarEvent {
  const NewCalendarEvent(this.workout);

  final WorkoutLog workout;

  List<Object> get props => [workout];
}

class LogoutEvent extends CalendarEvent {
  List<Object> get props => [];
}

class DeleteCalendarEvent extends CalendarEvent {
  const DeleteCalendarEvent(this.workout);

  final WorkoutLog workout;

  List<Object> get props => [workout];
}
