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
  final weightController = TextEditingController();

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
    weightController.dispose();

    super.dispose();
  }

  // //TODO: create update func
  // void updateDB() {
  //
  // }

  void addExerciseLog(int id) {
    ExerciseLog exercise = ExerciseLog(
        exercise: Exercise(
            id: 100,
            category: 1,
            name: nameController.text,
            sets: int.parse(setController.text),
            reps: int.parse(repController.text),
            weight: double.parse(weightController.text),
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
        title: const Text('Add your exercise'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Exercise name: " +
                      widget.exerciseData.exerciseLog.exercise.name,
                ),
                controller: nameController,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description: " +
                      widget.exerciseData.exerciseLog.exercise.description,
                ),
                controller: descController,
                keyboardType: TextInputType.text,
                minLines: 3,
                maxLines: 7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Sets: " +
                      widget.exerciseData.exerciseLog.exercise.sets.toString(),
                ),
                controller: setController,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Reps: " +
                      widget.exerciseData.exerciseLog.exercise.reps.toString(),
                ),
                controller: repController,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Weight: " +
                      widget.exerciseData.exerciseLog.exercise.weight
                          .toString() +
                      "KG",
                ),
                controller: weightController,
                keyboardType: TextInputType.number,
              ),
            ),

          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addExerciseLog(_exerciseDataId),
          tooltip: 'Add an exercise.',
          child: Icon(Icons.save),
        ),
    );
  }
}
