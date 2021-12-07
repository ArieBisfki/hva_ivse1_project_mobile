import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';

class WorkoutLogsOverview extends StatelessWidget {
  const WorkoutLogsOverview(this._selectedWorkouts, this.context, {Key? key})
      : super(key: key);
  final ValueNotifier<List<WorkoutLog>> _selectedWorkouts;
  final BuildContext context;

  deleteWorkout(WorkoutLog workout) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('The planned workout will be deleted'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    // TODO delete function
                    // TODO nullsafe
                    print("ID TO DELETE: " + workout.id.toString());
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
    return Expanded(
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
                  title: Text('${value[index].id}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // TODO give title
                      deleteWorkout(value[index]);
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
