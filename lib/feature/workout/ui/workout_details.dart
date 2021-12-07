import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/feature/calender/models/exercise.dart';

import '../../../workout_data.dart';

class WorkoutDetailsPage extends StatefulWidget {
  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: Icon(Icons.close, color: Colors.black, size: 30)),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: chestWorkout.length,
              itemBuilder: (BuildContext context, int index) {
                child:
                Container(
                  color: Colors.white,
                  child: ListTile(
                    isThreeLine: true,
                    leading: Container(
                      width: 90.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(workout[index]['leading'][0]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    title: Text(workout[index]['title']),
                    subtitle: Text(
                        '${workout[index]['subtitle']}\n${workout[index]['leading'][1]}'),
                    trailing: workout[index]['trailing'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
