part of 'calender_bloc.dart';

abstract class CalenderEvent extends Equatable {
  const CalenderEvent();
}

class GetCalenderEvent extends CalenderEvent {
  List<Object> get props => [];
}
