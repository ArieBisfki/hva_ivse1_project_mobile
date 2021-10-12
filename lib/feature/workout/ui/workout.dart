import 'package:flutter/material.dart';
import '../../../workout_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Workout extends StatefulWidget {
  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  addExercise() {
    workout.add({
      'leading': ['images/bench.jpg', '10 x'],
      'title': 'TEST MET KAI',
      'subtitle': 'subtitle',
      'trailing': Icon(Icons.chevron_right, size: 25)
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addExercise();
          },
          child: const Icon(Icons.navigation),
          backgroundColor: Colors.blue,
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
                    icon: Icon(Icons.close, color: Colors.black, size: 30)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '(Name of your workout)',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    Text(
                      '(kind of workout)',
                      style: TextStyle(fontSize: 17.0),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: workout.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
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
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          //onTap: () => _showSnackBar('Delete'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
