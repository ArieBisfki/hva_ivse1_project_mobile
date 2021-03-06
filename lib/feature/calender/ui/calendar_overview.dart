import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/common/widget/splash_screen.dart';
import 'package:ivse1_gymlife/feature/calender/bloc/calendar_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/calender/models/login_info.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/calender/ui/workoutLogs_overview.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key, required this.loginInfo}) : super(key: key);

  final LoginInfo loginInfo;

  @override
  _State createState() => _State();
}

class _State extends State<Calendar> {
  late ValueNotifier<List<WorkoutLog>> _selectedWorkouts;
  List<WorkoutLog> selectedWorkouts = [];
  List<WorkoutLog> workoutLogsForDay = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool _addWorkoutButton = true;
  bool _loggedIn = false;
  bool _ready = false;

  var isDialOpen = ValueNotifier<bool>(false);

  List<WorkoutLog> get list => workoutLogsForDay;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CalendarBloc>(context).add(ResetCalendar());
    _loggedIn = widget.loginInfo.loggenIn;
    _ready = widget.loginInfo.ready;

    selectedWorkouts = [];
    _selectedDay = _focusedDay;
    _selectedWorkouts = ValueNotifier(_getWorkoutLogsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedWorkouts.dispose();
    super.dispose();
  }

  List<WorkoutLog> _getWorkoutLogsForDay(DateTime day) {
    // retrieves workouts per day
    return selectedWorkouts
        .where((element) => DateTime.parse(element.date) == day)
        .toList();
  }

  List<WorkoutLog> _getWorkoutLogsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getWorkoutLogsForDay(d),
    ];
  }

  WorkoutLog getWorkoutItem() {
    // create example workout
    Exercise exercise = new Exercise(
      id: 1,
      category: 2,
      name: "Squats",
      sets: 3,
      description:
          ' A strength exercise in which the trainee lowers their hips from a standing position and then stands back up',
      reps: 12,
      weight: 40,
      image: 'none',
    );
    ExerciseLog exLog = new ExerciseLog(exercise: exercise);
    WorkoutLog workoutLog = new WorkoutLog(
        exerciseLogs: [exLog], id: null, date: _selectedDay!.toIso8601String());
    return workoutLog;
  }

  daysInRange(DateTime start, DateTime end) {
    List<DateTime> days = [];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      days.add(start.add(Duration(days: i)));
    }
    return days;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _addWorkoutButton = true;
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      workoutLogsForDay = _getWorkoutLogsForDay(selectedDay);
      _selectedWorkouts.value = _getWorkoutLogsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _addWorkoutButton = false;
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedWorkouts.value = _getWorkoutLogsForRange(start, end);
      workoutLogsForDay = _getWorkoutLogsForRange(start, end);
    } else if (start != null) {
      _selectedWorkouts.value = _getWorkoutLogsForDay(start);
      workoutLogsForDay = _getWorkoutLogsForDay(start);
    } else if (end != null) {
      _selectedWorkouts.value = _getWorkoutLogsForDay(end);
      workoutLogsForDay = _getWorkoutLogsForDay(end);
    }
  }

  // Add event to date
  dialAction(String title) {
    // add example workoutlog
    selectedWorkouts.add(
      getWorkoutItem(),
    );

    BlocProvider.of<CalendarBloc>(context)
        .add(NewCalendarEvent(getWorkoutItem(), _loggedIn));
    BlocProvider.of<CalendarBloc>(context).add(GetWorkoutsEvent());

    setState(() {
      _selectedWorkouts.value = _getWorkoutLogsForDay(_selectedDay!);
    });
  }

  logout() {
    BlocProvider.of<CalendarBloc>(context).add(LogoutEvent());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Logged out'),
    ));
  }

  // update calendar
  updateCalendar(List<WorkoutLog> state) {
    // fill local list with state data
    selectedWorkouts = state;

    if (_selectedDay == null) {
      // retrieve range of dates
      if (_rangeEnd != null) {
        state
            .where((element) =>
                DateTime.parse(element.date).isAfter(_rangeStart!) &&
                DateTime.parse(element.date).isBefore(_rangeEnd!))
            .toList();
      }
    } else {
      workoutLogsForDay = state
          .where((element) =>
              DateTime.parse(element.date).day == _selectedDay!.day)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {
        if (state is CalendarDataState && state.dataState is StateSuccess ||
            state is CalendarDataState && state.dataState is StateEmpty) {
          // retrieve data from database
          BlocProvider.of<CalendarBloc>(context).add(GetWorkoutsEvent());
        }
      },
      builder: (context, state) {
        if (state is CalendarInitial) {
          if (_ready) {
            BlocProvider.of<CalendarBloc>(context)
                .add(GetCalendarEvent(_loggedIn));
          }
        } else if (state is WorkoutsLoadedState) {
          updateCalendar(state.data);

          return WillPopScope(
            onWillPop: () async {
              if (isDialOpen.value) {
                isDialOpen.value = false;
                return false;
              }
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text('GymLife Calendar'),
                actions: <Widget>[
                  _loggedIn
                      ? IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "/login");
                            logout();
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "/login");
                          },
                        )
                ],
              ),
              floatingActionButton: _addWorkoutButton
                  ? SpeedDial(
                      icon: Icons.add,
                      activeIcon: Icons.close,
                      spacing: 3,
                      childPadding: const EdgeInsets.all(5),
                      spaceBetweenChildren: 4,
                      buttonSize: 56,
                      openCloseDial: isDialOpen,
                      iconTheme: IconThemeData(size: 24),
                      childrenButtonSize: 56.0,
                      direction: SpeedDialDirection.up,
                      overlayColor: Colors.black,
                      overlayOpacity: 0.5,
                      elevation: 8.0,
                      isOpenOnStart: false,
                      animationSpeed: 200,
                      children: [
                        SpeedDialChild(
                          child: const Icon(Icons.accessibility),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          label: 'Weights',
                          onTap: () => dialAction("Weights"),
                        ),
                        SpeedDialChild(
                          child: const Icon(Icons.accessible_sharp),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          label: 'Crossfit(Comming soon)',
                          //onTap: () => dialAction("Crossfit"),
                          onTap: () => {},
                        ),
                        SpeedDialChild(
                          child: const Icon(Icons.person),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          label: 'Cardio(Comming soon)',
                          visible: true,
                          //onTap: () => dialAction("Cardio"),
                          onTap: () => {},
                        ),
                      ],
                    )
                  : SizedBox(),
              body: Column(
                children: [
                  TableCalendar<WorkoutLog>(
                    firstDay: DateTime.utc(2010, 1, 1),
                    lastDay: DateTime.utc(2030, 1, 1),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    calendarFormat: _calendarFormat,
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getWorkoutLogsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                    ),
                    onDaySelected: _onDaySelected,
                    onRangeSelected: _onRangeSelected,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  // display list of workouts on a day
                  WorkoutLogsOverview(workoutLogsForDay, context, _loggedIn),
                  _loggedIn
                      ? const SizedBox.shrink()
                      : Container(
                          child: Row(
                            children: <Widget>[
                              Text('Don\'t have an account?'),
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/sign_up");
                                },
                                child: Text(
                                  "sign up",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                ],
              ),
            ),
          );
        } else if (state is CalendarDataState &&
            state.dataState is StateLoading) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: const SplashScreen(),
          );
        } else if (state is CalendarDataState &&
            state.dataState is StateError) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Gymlife'),
                automaticallyImplyLeading: false,
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Please go back',
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          padding: EdgeInsets.all(30.0),
                          icon:
                              Icon(Icons.close, color: Colors.black, size: 30)),
                    ),
                  ],
                ),
              ));
        }
        return const SplashScreen();
      },
    );
  }
}
