import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../workout_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class WorkoutPage extends StatefulWidget {
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

final snackBar = SnackBar(content: Text('Exercise deleted'));

class _WorkoutPageState extends State<WorkoutPage> {
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
                      '(Name of workout)',
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
                        key: UniqueKey(),
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        dismissal: SlidableDismissal(
                          child: SlidableDrawerDismissal(),
                          onDismissed: (actionType) {
                          _showSnackBar(
                          context,
                          actionType == SlideActionType.primary
                          ? 'Deleted'
                              : 'Dimiss Archive');
                          setState(() {
                            workout.removeAt(index);
                          });
                        },
                        onWillDismiss: (direction) => promptUser(),
                      ),

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
                          caption: 'Swipe to delete →',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => _showSnackBar(context, 'Deleted'),
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


  ///Shows the snackbar messages
  void _showSnackBar(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  ///To confirm the delete
  Future<bool> promptUser() async {
    String action;
    action = "delete";

    return await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text("Are you sure you want to $action?"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              // Dismiss the dialog and
              // also dismiss the swiped item
              Navigator.of(context).pop(true);
            },
          ),
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              // Dismiss the dialog but don't
              // dismiss the swiped item
              return Navigator.of(context).pop(false);
            },
          )
        ],
      ),
    ) ??
        false; // In case the user dismisses the dialog by clicking away from it
  }
}