## Code snippets state management

This code is used to fill the calendar with workouts. The listner and builder listen to a state which the code inside can take actions upon. The builder creates all of the front-end in a class.

The Bloc is the brain of the operation, Events are sent to tell him what to do.

First, Calendar initial is the current state. In this state the listner sends an event to retrieve the workouts from the database. This eventually returns a dataState determined by the response, this state is checked by the listner and when the response is a succes it lets the Bloc know the workouts are ready to be retrieved.

Finally, the workoutsLoaded state is returned. This state contains all the data needed for this page, so it can be used throughout the builder method.

```
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {
        if (state is CalendarDataState && state.dataState is StateSuccess ||
            state is CalendarDataState && state.dataState is StateEmpty) {
          // retrieve data from database
          BlocProvider.of<CalendarBloc>(context).add(GetWorkoutsEvent());
        }
      },
      builder: (context, state) {
        if (state is CalendarInitial) {
          BlocProvider.of<CalendarBloc>(context).add(GetCalendarEvent());
        } else if (state is WorkoutsLoadedState) {
          // fill local list with state data
          selectedWorkouts = state.data;
```


## Json formatter

This code formats an object to Json and back. It is used in combination with the local database from the SQlite library.

```
  WorkoutLog.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        exerciseLogs = (jsonDecode(json['exerciseLogs']) as List)
            .map((exerciseLog) => ExerciseLog.fromJson(exerciseLog))
            .toList(),
        //exerciseLogs = jsonDecode(json["exerciseLogs"]),
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'exerciseLogs': jsonEncode(exerciseLogs),
        'date': date,
      };