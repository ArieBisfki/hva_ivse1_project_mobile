import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ivse1_gymlife/common/base/data_state.dart';
import 'package:ivse1_gymlife/common/route/routes.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/workout/bloc/workout_bloc.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_adapter.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_repository.dart';

/// Workout page
/// @author Costa
class WorkoutPage extends StatefulWidget {
  WorkoutPage({required this.workoutLog, required this.exerciseData});

  final WorkoutLog workoutLog;
  final ExerciseData exerciseData;

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

final snackBarDelete = SnackBar(content: Text('Exercise deleted'));

class _WorkoutPageState extends State<WorkoutPage> {
  ExerciseLogDbAdapter adapter = new ExerciseLogDbAdapter();
  late final ExerciseLogRepository repo =
      new ExerciseLogRepository(dbAdapter: adapter);

  late ValueNotifier<List<ExerciseLog>> _selectedExercise;

  List<ExerciseLog> exercisesForWorkout = [];
  List<ExerciseLog> selectedExercise = [];
  int _workoutLogId = 0;
  int _exerciseDataId = 0;

  List<ExerciseLog> get list => exercisesForWorkout;

  var isDialOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    selectedExercise = [];
    _selectedExercise = ValueNotifier(_getExerciseForWorkout());
    _workoutLogId = widget.workoutLog.id!;
    _exerciseDataId = widget.exerciseData.id!;
  }

  List<ExerciseLog> _getExerciseForWorkout() {
    return selectedExercise.toList();
  }

  @override
  void dispose() {
    _selectedExercise.dispose();
    super.dispose();
  }

  updateExercise(List<ExerciseLog> state) {
    selectedExercise = state;
    exercisesForWorkout = state.toList();
  }

  /// deleteExerciseLog(int id)
  /// This method removes and exercise from the workout
  void deleteExerciseLog(ExerciseData exerciseData) {
    setState(() async {
      await repo.deleteExercises(exerciseData.exerciseLog, exerciseData.id);
    });
    BlocProvider.of<WorkoutBloc>(context).add(ResetExercise());
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
          BlocProvider.of<WorkoutBloc>(context)
              .add(LoadExercisesEvent(_workoutLogId));
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
                            BlocProvider.of<WorkoutBloc>(context)
                                .add(ResetExercise());
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
                            'Workout ID: ' + widget.workoutLog.id.toString(),
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Text(
                            'Type: ' +
                                widget.workoutLog.exerciseLogs.first.exercise
                                    .category
                                    .toString(),
                            style: TextStyle(fontSize: 17.0),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<List<ExerciseLog>>(
                        valueListenable: ValueNotifier(exercisesForWorkout),
                        builder: (context, value, _) {
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Slidable(
                                key: UniqueKey(),
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                dismissal: SlidableDismissal(
                                  child: SlidableDrawerDismissal(),
                                  onDismissed: (actionType) {
                                    _showSnackBar(
                                        context,
                                        actionType == SlideActionType.primary
                                            ? 'Deleted'
                                            : 'Dimiss Archive');
                                    setState(() {
                                      deleteExerciseLog(ExerciseData(
                                          id: _workoutLogId,
                                          exerciseLog: value[index]));
                                    });
                                  },
                                  onWillDismiss: (direction) => promptUser(),
                                ),
                                child: Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    isThreeLine: true,
                                    title: Text(value[index].exercise.name),
                                    subtitle: Text("Weight: " +
                                        value[index]
                                            .exercise
                                            .weight
                                            .toString() +
                                        "\nSets:" +
                                        value[index].exercise.sets.toString() +
                                        "\nReps:" +
                                        value[index].exercise.reps.toString() +
                                        "\nDescription:" +
                                        value[index].exercise.description),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteExerciseLog(ExerciseData(
                                            id: _workoutLogId,
                                            exerciseLog: value[index]));
                                      },
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Swipe right to delete ->',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => {
                  Navigator.pushNamed(context, Routes.add_workout,
                      arguments: ExerciseData(
                        id: _workoutLogId,
                        exerciseLog: ExerciseLog(
                          exercise: Exercise(
                              id: 0,
                              category: 0,
                              name: "",
                              description: "",
                              image: "",
                              sets: 0,
                              reps: 0,
                              weight: 0),
                        ),
                      ))
                },
                tooltip: 'Add an exercise',
                label: Text("Add exercise"),
                icon: Icon(Icons.add),
              ),
            ),
          );
        } else if (state is WorkoutDataState &&
            state.dataState is StateLoading) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: const SizedBox.shrink(),
          );
        } else if (state is WorkoutDataState && state.dataState is StateError) {
          _showSnackBar(context,
              "Oeps! a wild error has appeared! Do you want to challenge the error?");
          Navigator.of(context).pop();
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
