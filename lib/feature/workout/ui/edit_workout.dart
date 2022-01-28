import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';

class EditWorkout extends StatefulWidget{
  const EditWorkout({Key? key, required this.exercise}) : super(key: key);

  final Exercise exercise;

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit exercise'),
        actions: [],
      ),
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
                'Name: ' + widget.exercise.name.toString(),
                style: TextStyle(fontSize: 17.0),
              )],
          ),
        ),
      ]),
    ));
  }
}