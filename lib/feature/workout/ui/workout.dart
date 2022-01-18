import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import '../../../workout_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/feature/workout/bloc/workout_bloc.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_adapter.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_repository.dart';

import '../../../workout_data.dart';

class WorkoutPage extends StatefulWidget {
  WorkoutPage({required this.workoutLog});
  final WorkoutLog workoutLog;
  // TODO voeg ID en Date toe aan workout lijst

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

final snackBar = SnackBar(content: Text('Exercise deleted'));

class _WorkoutPageState extends State<WorkoutPage> {
  ExerciseLogDbAdapter adapter = new ExerciseLogDbAdapter();
  late final ExerciseLogRepository repo =
      new ExerciseLogRepository(dbAdapter: adapter);

  late ValueNotifier<List<ExerciseData>> _selectedExercise;

  List<ExerciseData> exercisesForWorkout = [];
  List<ExerciseData> selectedExercise = [];

  List<ExerciseData> get list => exercisesForWorkout;

  var isDialOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    selectedExercise = [];
    _selectedExercise = ValueNotifier(_getExerciseDataForWorkout());
  }

  List<ExerciseData> _getExerciseDataForWorkout() {
    return selectedExercise.toList();
  }

  @override
  void dispose() {
    _selectedExercise.dispose();
    super.dispose();
  }

  ExerciseData getExerciseItem() {
    ExerciseData exercise = new ExerciseData(
        id: "1",
        image: '',
        title: 'a',
        sets: null,
        description: '',
        weight: null,
        reps: null);
    return exercise;
  }

  dialAction(String title) {
    exercisesForWorkout.add(
      getExerciseItem(),
    );

    BlocProvider.of<WorkoutBloc>(context)
        .add(NewExerciseEvent(getExerciseItem()));
    BlocProvider.of<WorkoutBloc>(context).add(GetExercisesEvent());
  }

  updateExercise(List<ExerciseData> state) {
    selectedExercise = state;
    exercisesForWorkout = state.toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutBloc, WorkoutState>(
      listener: (context, state) {
        if (state is WorkoutDataState && state.dataState is StateSuccess ||
            state is WorkoutDataState && state.dataState is StateEmpty) {
          // retrieve data from database
          BlocProvider.of<WorkoutBloc>(context).add(GetExercisesEvent());
        }
      },
      builder: (context, state) {
        if (state is WorkoutInitial) {
          BlocProvider.of<WorkoutBloc>(context).add(GetExerciseEvent());
        } else if (state is ExercisesLoadedState) {
          updateExercise(state.data);
          return WillPopScope(
              onWillPop: () async {
                if (isDialOpen.value) {
                  isDialOpen.value = false;
                  return false;
                }
                return true;
              },
              child: Scaffold(
                  body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
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
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '(Name of workout)',
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Text(
                            '(kind of workout)',
                            style: TextStyle(fontSize: 17.0),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<List<ExerciseData>>(
                        valueListenable: ValueNotifier(selectedExercise),
                        builder: (context, value, _) {
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {

                                  },
                                  title: Text('Workout ID: ${value[index].id}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                        _showSnackBar(context, "Deleted");
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     physics: BouncingScrollPhysics(),
                    //     itemCount: workout.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Slidable(
                    //         key: UniqueKey(),
                    //         actionPane: SlidableDrawerActionPane(),
                    //         actionExtentRatio: 0.25,
                    //         dismissal: SlidableDismissal(
                    //           child: SlidableDrawerDismissal(),
                    //           onDismissed: (actionType) {
                    //             _showSnackBar(
                    //                 context,
                    //                 actionType == SlideActionType.primary
                    //                     ? 'Deleted'
                    //                     : 'Dimiss Archive');
                    //             setState(() {
                    //               workout.removeAt(index);
                    //             });
                    //           },
                    //           onWillDismiss: (direction) => promptUser(),
                    //         ),
                    //         child: Container(
                    //           color: Colors.white,
                    //           child: ListTile(
                    //             isThreeLine: true,
                    //             leading: Container(
                    //               width: 90.0,
                    //               decoration: BoxDecoration(
                    //                 image: DecorationImage(
                    //                   image: AssetImage(
                    //                       workout[index]['leading'][0]),
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //                 borderRadius: BorderRadius.circular(10.0),
                    //               ),
                    //             ),
                    //             title: Text(workout[index]['title']),
                    //             subtitle: Text(
                    //                 '${workout[index]['subtitle']}\n${workout[index]['leading'][1]}'),
                    //             trailing: workout[index]['trailing'],
                    //           ),
                    //         ),
                    //         actions: <Widget>[
                    //           IconSlideAction(
                    //             caption: 'Swipe to delete →',
                    //             color: Colors.red,
                    //             icon: Icons.delete,
                    //             onTap: () => _showSnackBar(context, 'Deleted'),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              )));
        } else if (state is WorkoutDataState &&
            state.dataState is StateLoading) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: const SizedBox.shrink(),
          );
        } else if (state is WorkoutDataState && state.dataState is StateError) {
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

  ///Shows the snackbar messages
  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  ///To confirm the delete
  Future<bool> promptUser() async {
    String action;
    action = "delete";

    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text("Are you sure you want to $action?"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Ok"),
                onPressed: () {
                  // Dismiss the dialog and
                  // also dismiss the swiped item
                  Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text('Cancel'),
                onPressed: () {
                  // Dismiss the dialog but don't
                  // dismiss the swiped item
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false; // In case the user dismisses the dialog by clicking away from it
  }
}
