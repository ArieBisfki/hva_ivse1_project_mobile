import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository calendarRepository;

  CalendarBloc({required this.calendarRepository}) : super(CalendarInitial());

  CalendarState get initialState => CalendarInitial();

  // crazy example
  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is ResetCalendar) {
      yield CalendarInitial();
    }
    if (event is GetCalendarEvent) {
      yield CalendarDataState(StateLoading());

      // make DataResponse data = repo call

      // make switch to handle data.status errors or yield succes states
      // default is unknows state
    }
  }
}
