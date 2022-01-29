import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/workout/bloc/workout_bloc.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_adapter.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_repository.dart';

class EditWorkout extends StatefulWidget {
  const EditWorkout({Key? key, required this.exerciseData}) : super(key: key);

  final ExerciseData exerciseData;

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  ExerciseLogDbAdapter adapter = new ExerciseLogDbAdapter();
  late final ExerciseLogRepository repo =
      new ExerciseLogRepository(dbAdapter: adapter);

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final setController = TextEditingController();
  final repController = TextEditingController();

  int _exerciseDataId = 0;

  @override
  void initState() {
    _exerciseDataId = widget.exerciseData.id!;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    nameController.dispose();
    descController.dispose();
    setController.dispose();
    repController.dispose();
    super.dispose();
  }

  // //TODO: create update func
  // void updateDB() {
  //
  // }

  void addExerciseLog(int id) {
    // print(_exerciseDataId);
    // _exerciseDataId = widget.exerciseData.id!;
    // print(_exerciseDataId);

    ExerciseLog exercise = ExerciseLog(
        exercise: Exercise(
            id: 100,
            category: 1,
            name: nameController.text,
            sets: 6,
            reps: 2,
            weight: 3,
            image: "g",
            description: descController.text));
    setState(() {
      repo.createExercise(exercise, id);
      BlocProvider.of<WorkoutBloc>(context).add(ResetExercise());
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:
                    "Name: " + widget.exerciseData.exerciseLog.exercise.name,
              ),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Description: " +
                    widget.exerciseData.exerciseLog.exercise.description,
              ),
              controller: descController,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Sets: " +
                    widget.exerciseData.exerciseLog.exercise.sets.toString(),
              ),
              controller: setController,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Reps: " +
                    widget.exerciseData.exerciseLog.exercise.reps.toString(),
              ),
              controller: repController,
            ),
            FloatingActionButton(
              onPressed: () => addExerciseLog(_exerciseDataId),
              tooltip: 'Update database',
              child: Icon(Icons.update),
            ),
          ],
        ),
      ),
    );
  }
}
