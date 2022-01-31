import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise_log.dart';
import 'package:ivse1_gymlife/feature/workout/bloc/workout_bloc.dart';
import 'package:ivse1_gymlife/feature/workout/models/exercise_data.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_adapter.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_repository.dart';

///Add workout class
///@author Costa
class AddWorkout extends StatefulWidget {
  const AddWorkout({Key? key, required this.exerciseData}) : super(key: key);

  final ExerciseData exerciseData;

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  //adapter
  ExerciseLogDbAdapter adapter = new ExerciseLogDbAdapter();

  //repository
  late final ExerciseLogRepository repo =
  new ExerciseLogRepository(dbAdapter: adapter);

  //the text controllers to add a exercise
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final setController = TextEditingController();
  final repController = TextEditingController();
  final weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
  int _exerciseDataId = 0;

  Random random = new Random();
  static const int RANDOM_INT_MAX = 999;

  //because we only have 1 category for now
  int category = 1;
  String image = "";

  /// init state
  @override
  void initState() {
    _exerciseDataId = widget.exerciseData.id!;
    super.initState();
  }

  /// dispose
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    nameController.dispose();
    descController.dispose();
    setController.dispose();
    repController.dispose();
    weightController.dispose();

    super.dispose();
  }

  /// addExerciseLog(int id)
  /// This method adds and exercise to the workout
  void addExerciseLog(int id) {
    int randomId = random.nextInt(RANDOM_INT_MAX);
    // create an exercise log to put the exercise in
    ExerciseLog exercise = ExerciseLog(
        exercise: Exercise(
            id: randomId,
            category: category,
            name: nameController.text,
            sets: int.parse(setController.text),
            reps: int.parse(repController.text),
            weight: double.parse(weightController.text),
            image: image,
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
          title: const Text('Add an exercise'),
        ),
        body: Form(
          key: _formKey,
          //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Exercise name: " +
                        widget.exerciseData.exerciseLog.exercise.name,
                  ),
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description: " +
                        widget.exerciseData.exerciseLog.exercise.description,
                  ),
                  controller: descController,
                  keyboardType: TextInputType.text,
                  minLines: 3,
                  maxLines: 7,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Sets: " +
                        widget.exerciseData.exerciseLog.exercise.sets
                            .toString(),
                  ),
                  controller: setController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Sets';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Reps: " +
                        widget.exerciseData.exerciseLog.exercise.reps
                            .toString(),
                  ),
                  controller: repController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter reps';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Weight: " +
                        widget.exerciseData.exerciseLog.exercise.weight
                            .toString() +
                        "KG",
                  ),
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount of Weight in KiloGrams (KG)';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                addExerciseLog(_exerciseDataId);
              }
            },
    tooltip: 'Add an exercise',
    child: Icon(Icons.save),
    ),
    );
  }
}
