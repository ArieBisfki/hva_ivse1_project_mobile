import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/feature/calender/bloc/calendar_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'dart:convert';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Calendar> {
  late ValueNotifier<List<Event>> _selectedEvents;
  Map<DateTime, List<Event>> selectedEvents = {};
  late ValueNotifier<List<WorkoutLog>> _selectedWorkouts;
  Map<DateTime, List<WorkoutLog>> selectedWorkouts = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool _addWorkoutButton = true;

  var isDialOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    selectedWorkouts = {};
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _selectedWorkouts = ValueNotifier(_getEventsForDay2(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return selectedEvents[day] ?? [];
  }

  List<WorkoutLog> _getEventsForDay2(DateTime day) {
    return selectedWorkouts[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<WorkoutLog> _getEventsForRange2(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay2(d),
    ];
  }

  WorkoutLog getWorkoutItem() {
    // create with empty workout format
    Exercise exercise = new Exercise(id: 1, category: 1, name: "Kastzijn");
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

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onDaySelected2(DateTime selectedDay, DateTime focusedDay) {
    _addWorkoutButton = true;
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedWorkouts.value = _getEventsForDay2(selectedDay);
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
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  void _onRangeSelected2(DateTime? start, DateTime? end, DateTime focusedDay) {
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
      _selectedWorkouts.value = _getEventsForRange2(start, end);
    } else if (start != null) {
      _selectedWorkouts.value = _getEventsForDay2(start);
    } else if (end != null) {
      _selectedWorkouts.value = _getEventsForDay2(end);
    }
  }

  // Add event to date
  dialAction(String title) {
    if (selectedEvents[_selectedDay] != null) {
      selectedEvents[_selectedDay]!.add(
        Event(title: title),
      );
      // lege workout maken van de gekozen dial
      BlocProvider.of<CalendarBloc>(context)
          .add(NewCalendarEvent(getWorkoutItem()));
    } else {
      selectedEvents[_selectedDay!] = [Event(title: title)];
      BlocProvider.of<CalendarBloc>(context)
          .add(NewCalendarEvent(getWorkoutItem()));
    }

    _selectedEvents.value = _getEventsForDay(_selectedDay!);
    setState(() {});
  }

  dialAction2(String title) {
    if (selectedWorkouts[_selectedDay] != null) {
      selectedWorkouts[_selectedDay]!.add(
        getWorkoutItem(),
      );
      // lege workout maken van de gekozen dial
      BlocProvider.of<CalendarBloc>(context)
          .add(NewCalendarEvent(getWorkoutItem()));
    } else {
      selectedEvents[_selectedDay!] = [Event(title: title)];
      BlocProvider.of<CalendarBloc>(context)
          .add(NewCalendarEvent(getWorkoutItem()));
    }

    _selectedWorkouts.value = _getEventsForDay2(_selectedDay!);
    setState(() {});
  }

  deleteWorkout(String title) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('The planned workout will be deleted'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    if (selectedEvents[_selectedDay] != null) {
                      //TODO delete function
                    }

                    _selectedEvents.value = _getEventsForDay(_selectedDay!);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text('yes')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('no'),
              )
            ],
          );
        });
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
          BlocProvider.of<CalendarBloc>(context).add(GetCalendarEvent());
        } else if (state is WorkoutsLoadedState) {
          DateTime parsedDate = DateTime.parse('1974-03-20 00:00:00.000');

          Map<DateTime, List<WorkoutLog>> dataLogs = {
            for (var v in state.data) DateTime.parse(v.date): [v]
          };

          selectedWorkouts.addAll(dataLogs);

          //state.data.forEach((workoutLog) => selectedWorkouts.addAll());

          print("STATETEST: " + state.data[0].id.toString());
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
                title: Text('GymLife Calendar'),
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
                          onTap: () => dialAction2("Weights"),
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
                    eventLoader: _getEventsForDay2,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                    ),
                    onDaySelected: _onDaySelected2,
                    onRangeSelected: _onRangeSelected2,
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
                  Expanded(
                    child: ValueListenableBuilder<List<WorkoutLog>>(
                      valueListenable: _selectedWorkouts,
                      builder: (context, value, _) {
                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/workout");
                                },
                                title: Text('${value[index]}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    //deleteWorkout(value[index].title);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
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
            child: const SizedBox.shrink(),
          );
        } else if (state is CalendarDataState &&
            state.dataState is StateError) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: const SizedBox.shrink(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
