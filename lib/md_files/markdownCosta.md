# Mini portfolio Costa van Elsas


## Individual contributions to Gymlife

### Introduction

Welcome to my mini-portfolio for the project Software Engineering. I worked on the front-end of the
Gymlife application. The original plan was for us all to do some of the front-end and some of the
back-end. This did not work out for us. So me and Kai focussed on the front-end, Arie and Soufiane
focussed on the back-end of the Gymlife application. During the project I had a lot of health
issues. This made it very hard to keep up with all the work. I had surgery for my back. Luckily my
teammates were very supportive. I made up for a whole lot of lost time near the end of the project.
Kai was my partner for the front-end. We had great communication and since he made a lot of progress
in my absence he showed me how the project was structured since it was changed a lot from where we
started.

### What did I work on?

As I stated in the introduction I worked on the front-end of our Gymlife application. Here is a list
of things that I did:

- Workout page
- Add a workout
- Delete a workout
- Created model for the database
- Workout category's (*not used*)
- Exercise picker (*not used*)

### Who did I do it with?

I worked on the front-end with Kai. He was my "mentor". He already had some experience in Flutter, I
did not. He helped me with a lot of problems and was always available. We also had interaction with
the whole team to explain everything. So me and Kai explained the front-end Arie and Soufiane
explained the back-end to us. This way we all know what everything in the front- and back-end is
supposed to do.

### Fraction of my efforts

The most of my efforts went in to the Workout page. In the workout page you can see, add and delete
exercises within a workout. I also styled the pages.

### What took too long?

*Everything*, I say that because in my opinion almost all my tasks took too long.
The reason behind is that as I stated in my introduction I had back surgery. Which caused some 
absence. Kai created a whole new project structure which took me some time to understand. It was
pretty complex to understand. It was a completely new technology for me, and when I came back from my
recovery there already was a complex structure. I needed time to adapt.

## Code snippet - adding an exercise to a workout

When you add an exercise to a specific workout you will need a couple of things. The ID of the workout
the ID of the exercise log and the exercise it self. 

When you are in the workout page, I created a Floating Action Button (FAB).
The FAB passes the context, a route (that leads to add workout). As arguments I pass an empty 
ExerciseData, in the exercise data is an exercise log with the exercise in the log.
```
 floatingActionButton: FloatingActionButton.extended(
                  onPressed: () => {
                    Navigator.pushNamed(context, Routes.add_workout,
                        arguments: ExerciseData(
                          id: _workoutLogId,
                          exerciseLog: ExerciseLog(
                            exercise: Exercise(
                                id: 0,
                                category: 0,
                                name: "",
                                description: "",
                                image: "",
                                sets: 0,
                                reps: 0,
                                weight: 0),
                          ),
                        ))
                  },
                  tooltip: 'Add an exercise',
                  label: Text("Add exercise"),
                  icon: Icon(Icons.add),
                ),
```
In the add_workout class I can call upon the ExerciseData which in first instance is empty because
we passed and empty one. In the add_workout class the ExerciseData is filled by using the next method:

```
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
```

This method is called upon when all the data is filled in the text boxes on the page and the FAB is 
clicked to add the exercise. This method uses the createExercise method from the workout repository.

```
  @override
  Future<DataResponse<int>> createExercise(
      ExerciseLog exerciseLog, int? id) async {
    try {
      final WorkoutLog request = await dbAdapter.getWorkout(id!);
      request.exerciseLogs.add(exerciseLog);

      final int response = await dbAdapter.addExercise(request);

      if (response == 0) {
        return DataResponse<int>.connectivityError();
      }

      return DataResponse<int>.success(response);
    } catch (e) {
      return DataResponse<int>.error('Error', error: e);
    }
  }
```

This method passes an ExerciseLog and an ID. The ID is the workout ID so the application knows where
to add the exercise. The ExerciseLog is the log that we passed in the add_workout class.
This method uses the adapter to call upon our database.

```
 Future addExercise(WorkoutLog ed) async {
    final Database db = await LocalDatabase().db;
    return db.update('workouts', ed.toJson(), where: "id = ${ed.id}");
  }
```

This method updates our database with the new data that is added.

## Code snippet
