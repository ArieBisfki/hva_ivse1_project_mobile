import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_repository_device.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final WorkoutLogRepositoryDevice calendarRepository;

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

      if (result.data != null) {
        _workouts = result.data!;
      }

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
      final DataResponse<dynamic> result =
          await calendarRepository.createWorkout(event.workout);

      final DataResponse<List<WorkoutLog>> recall =
          await calendarRepository.getWorkouts();

      if (recall.data != null) {
        _workouts = recall.data!;
      }

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
    if (event is DeleteCalendarEvent) {
      final DataResponse<dynamic> result =
          await calendarRepository.deleteWorkout(event.workout);

      _workouts.remove(event.workout);

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
