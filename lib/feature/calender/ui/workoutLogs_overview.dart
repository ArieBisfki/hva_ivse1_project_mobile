import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivse1_gymlife/common/route/routes.dart';
import 'package:ivse1_gymlife/feature/calender/bloc/calendar_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';
import 'package:ivse1_gymlife/feature/workout/bloc/workout_bloc.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/ui/workout.dart';
import 'package:ivse1_gymlife/workout_data.dart';

class WorkoutLogsOverview extends StatefulWidget {
  const WorkoutLogsOverview(this.workoutLogs, this.context, {Key? key})
      : super(key: key);
  final List<WorkoutLog> workoutLogs;
  final BuildContext context;

  @override
  State<WorkoutLogsOverview> createState() => _WorkoutLogsOverviewState();
}

class _WorkoutLogsOverviewState extends State<WorkoutLogsOverview> {
  deleteWorkout(WorkoutLog workout) {
    setState(() {
      BlocProvider.of<CalendarBloc>(widget.context)
          .add(DeleteCalendarEvent(workout));
    });
    Navigator.pop(widget.context);
  }

  deleteWorkoutDialog(WorkoutLog workout) {
    showDialog(
        context: widget.context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('The planned workout will be deleted'),
            actions: <Widget>[
              TextButton(
                onPressed: () => deleteWorkout(workout),
                child: Text('yes'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('no'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorkoutBloc>(context);
    return Expanded(
      child: ValueListenableBuilder<List<WorkoutLog>>(
        valueListenable: ValueNotifier(widget.workoutLogs),
        builder: (context, value, _) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, "/workout",
                        arguments: value[index]);
                  },
                  title: Text('Workout ID: ${value[index].id}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteWorkoutDialog(value[index]);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
