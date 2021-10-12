import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../workout_data.dart';

class Workout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
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
                    return ListTile(
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
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}