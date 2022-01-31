import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/common/http/data_reponse_E.dart';
import 'package:ivse1_gymlife/common/http/response.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_repository_API.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_repository_adapter.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_repository_device.dart';
import 'package:ivse1_gymlife/feature/login/recources/login_api.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final WorkoutLogRepositoryDevice calendarDeviceRepository;
  final WorkoutLogRepositoryAPI calendarAPIRepository;
  final LoginApi loginApi;

  CalendarBloc({
    required this.calendarDeviceRepository,
    required this.calendarAPIRepository,
    required this.loginApi,
  }) : super(CalendarInitial());

  CalendarState get initialState => CalendarInitial();

  List<WorkoutLog> _workouts = [];
  final storage = new FlutterSecureStorage();

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

      // logged user uses api, free used stores on device
      WorkoutLogRepositoryAdapter repo = new WorkoutLogRepositoryAdapter(
          calendarAPIRepository, calendarDeviceRepository, loginApi);
      final Either<DataResponseE, DataResponse<List<WorkoutLog>>> result =
          await repo.getWorkouts(event.loggedIn);

      if (result.isRight) {
        _workouts = result.right.data!;

        switch (result.right.status) {
          case Status.Loading:
            yield CalendarDataState(StateLoading());
            break;
          case Status.Success:
            if (result.right.data == null || result.right.data!.isEmpty) {
              yield CalendarDataState(StateEmpty());
            } else {
              yield CalendarDataState(StateSuccess(result));
            }
            break;
          default:
            print('Unknow state in ${toString()}: ${state.toString()}');
        }
      } else {
        yield CalendarDataState(StateError("oops"));
      }
    }
    if (event is GetWorkoutsEvent) {
      yield WorkoutsLoadedState(_workouts);
    }
    if (event is NewCalendarEvent) {
      WorkoutLogRepositoryAdapter repo = new WorkoutLogRepositoryAdapter(
          calendarAPIRepository, calendarDeviceRepository, loginApi);
      final Either<DataResponseE, DataResponse<dynamic>> result =
          await repo.createWorkout(event.workout);

      final Either<DataResponseE, DataResponse<List<WorkoutLog>>> recall =
          await repo.getWorkouts(event.loggedIn);

      if (recall.isRight) {
        _workouts = recall.right.data!;
        switch (result.right.status) {
          case Status.Loading:
            yield CalendarDataState(StateLoading());
            break;
          case Status.Success:
            yield CalendarDataState(
                StateSuccess<WorkoutLog>(result.right.data));
            break;
          default:
        }
      }
    }
    if (event is DeleteCalendarEvent) {
      WorkoutLogRepositoryAdapter repo = new WorkoutLogRepositoryAdapter(
          calendarAPIRepository, calendarDeviceRepository, loginApi);
      final Either<DataResponseE, DataResponse<int>> result =
          await repo.deleteWorkout(event.workout);

      _workouts.remove(event.workout);

      if (result.isRight) {
        switch (result.right.status) {
          case Status.Loading:
            yield CalendarDataState(StateLoading());
            break;
          case Status.Success:
            yield CalendarDataState(
                StateSuccess<WorkoutLog>(result.right.data));
            break;
          default:
        }
      }
    }
    if (event is LogoutEvent) {
      storage.delete(key: "accessToken");
      storage.delete(key: "refreshToken");
      storage.delete(key: "accessTokenExpiresIn");
      storage.delete(key: "refreshTokenExpiresIn");
    }
  }
}
