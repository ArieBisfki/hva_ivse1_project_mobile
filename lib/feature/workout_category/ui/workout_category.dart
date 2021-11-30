import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WorkoutCategoryScreen extends StatefulWidget {
  const WorkoutCategoryScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutCategoryScreen> createState() => _WorkoutCategoryScreenState();
}

class _WorkoutCategoryScreenState extends State<WorkoutCategoryScreen> {
  List<String> someList = ["Chest", "Back", "Legs", "Core", "Shoulders", "Arms"];

  List<Widget> _createChildren() {
    return new List<Widget>.generate(someList.length, (int index) {
      return Card(child: ListTile(title: Text(someList[index].toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Categories'),
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
