import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_repository_device.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepositoryDevice calendarRepository;

  CalendarBloc({required this.calendarRepository}) : super(CalendarInitial());

  CalendarState get initialState => CalendarInitial();

  List<WorkoutLog> _workouts = [];

  /// Returns workout items from memory
  List<WorkoutLog> get workouts => _workouts;

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is ResetCalendar) {
      yield CalendarInitial();
    }
    if (event is GetCalendarEvent) {
      yield CalendarDataState(StateLoading());

      final DataResponse<List<WorkoutLog>> result =
          await calendarRepository.getWorkouts();

      _workouts = result.data!;

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
    if (event is GetWorkoutsEvent) {
      yield WorkoutsLoadedState(_workouts);
    }
    if (event is NewCalendarEvent) {
      final DataResponse<WorkoutLog> result =
          await calendarRepository.createWorkout(event.workout);

      switch (result.status) {
        case Status.Error:
          yield CalendarDataState(StateError(result.message.toString()));
          break;
        case Status.Loading:
          yield CalendarDataState(StateLoading());
          break;
        case Status.Success:
          yield CalendarDataState(StateSuccess<WorkoutLog>(result.data));
          break;
        default:
      }
    }
  }
}