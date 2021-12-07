import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/feature/calender/models/workoutLog.dart';

class WorkoutLogsOverview extends StatelessWidget {
  const WorkoutLogsOverview(this._selectedWorkouts, {Key? key})
      : super(key: key);
  final ValueNotifier<List<WorkoutLog>> _selectedWorkouts;

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
                      // deleteWorkout(value[index].id.toString());
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
