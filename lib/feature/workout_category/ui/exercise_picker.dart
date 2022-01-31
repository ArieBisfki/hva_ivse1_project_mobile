import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';

class ExercisePicker extends StatelessWidget {
  const ExercisePicker({Key? key}) : super(key: key);

  List<Widget> _createChildren() {
    List<Exercise> specificExerciselist = [
      Exercise(
        id: 1, category: 1, name: "Kastzijn",
        sets: 1, description: 'aa', reps: 1, weight: 2, image: 'aa'
      )
    ];

    return new List<Widget>.generate(specificExerciselist.length, (int index) {
      return Card(
          child: ListTile(title: Text(specificExerciselist[index].toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise List'),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: _createChildren(),
            ),
          ),
        ),
      ),
    );
  }
}
