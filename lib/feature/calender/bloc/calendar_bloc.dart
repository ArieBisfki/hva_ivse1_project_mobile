import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workout.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository calendarRepository;

  CalendarBloc({required this.calendarRepository}) : super(CalendarInitial());

  CalendarState get initialState => CalendarInitial();

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is ResetCalendar) {
      yield CalendarInitial();
    }
    if (event is GetCalendarEvent) {
      yield CalendarDataState(StateLoading());

      final DataResponse<List<Workout>> result =
          calendarRepository.getWorkouts();

      switch (result.status) {
        case Status.Error:
          yield CalendarDataState(StateError(result.message.toString()));
          break;
        case Status.Loading:
          yield CalendarDataState(StateLoading());
          break;
        case Status.Success:
          if (result.data == null || result.data!.isEmpty) {
            yield CalendarDataState(StateEmpty());
          } else {
            yield CalendarDataState(StateSuccess(result));
          }
          break;
        default:
          print('Unknow state in ${toString()}: ${state.toString()}');
      }
    }
    if (event is NewCalendarEvent) {
      final DataResponse<Workout> result =
          await calendarRepository.createWorkout(event.workout);

      switch (result.status) {
        case Status.Error:
          yield CalendarDataState(StateError(result.message.toString()));
          break;
        case Status.Loading:
          yield CalendarDataState(StateLoading());
          break;
        case Status.Success:
          yield CalendarDataState(StateSuccess<Workout>(result.data));
          break;
        default:
      }
    }
  }
}
