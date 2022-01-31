# Mini portfolio Kai van den Broek


## Individual contributions

### What did I work on?
Unfortunately, I only worked on the development of the mobile application, which in our case is the front end. I wanted to do some work for the backend but the goals of the app kept me busy.
So what did i precisely work on:
- App routing
- Calendar
- Login
- Bloc state management
- SQlite save to device
- Calls to backend
- Adapter to switch between backend and device storage
  
### Who did I do it with?
My main partner with the app was Costa. I gave him some simpler tasks since he is new to the language and not 100% healthy throughout the whole project. Arie helped me with the SQlite stuff since I
forgot a lot about json formatting. He also assisted me with a lot of backend calls because he worked on the backend.

### Fraction of my efforts
The application is mostly my work, I gave Costa some easier tasks and Arie helped me with the models, backend calls and device database code. So to sum it up i would say the login screens were a collaboration and the calendar screen was my main project.

### What took too long?
I was stuck on the usage of RQlite for a while, that's why I asked Arie to help me. SQlite is a library that allows an application to store data on a device. It’s a new technology for me and it was a little difficult to make it work with the flutter state management.


## Snippet best quality - state management

From my point of view quality code is readable, easy to use and relatively quick to deploy. The usage of the Flutter Bloc library is a good example.

This implementation of state management supplies the calendar overview with its workouts. Using a form of state management makes the code a lot more testable, because you can always find out in what state the programm is.

To initiate the bloc and add it to the app you must declare it on the main file. To use it in the UI you can create a bloc object to react to new states. In our project we primarily use a BlocConsumer, this includes a listner and a builder. The listner and builder listen to a state which the code inside can take actions upon. The builder can create and alter front-end widgets in a class.

Now the UI is listning, we can create some business logic. We need States, events and a Bloc class. The Bloc is the brain of the operation, events are sent to tell him what to do, and states are returned to the UI.

First, Calendar initial is the current state. In this state an event to retrieve the workouts from the database is sent to the bloc. This eventually returns a dataState(or error) determined by the response, this state is checked by the listner and when the response is a succes it lets the Bloc know the workouts are ready to be retrieved.

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
link to repository: 
- UI: https://github.com/ArieBisfki/hva_ivse1_project_mobile/blob/master/lib/feature/calender/ui/calendar_overview.dart
- Bloc logic: https://github.com/ArieBisfki/hva_ivse1_project_mobile/tree/master/lib/feature/calender/bloc

link to library: https://pub.dev/packages/flutter_bloc

## Snippet highest complexity - Local or external data

In this app the data can be stored either on the phone itself or in a local database. We did this to lighten the load of the theoretical database of the app. Users without an account will use the storage on their phone to store workouts. If the user is logged in all their data will be stored in the database.

To make this concept work i made an adapter to guide the repository requests in the right direction. The adapter checks if the user is logged in and directs the data.

One of the methods in the adapter:
```
    Future<Either<DataResponseE, DataResponse<int>>> createWorkout(
    WorkoutLog workout,
  ) async {
    if (await isLoggedIn()) {
      return apiRepo.createWorkout(workout);
    } else {
      return deviceRepo.createWorkout(workout);
    }
  }
```

In short, if the api call is a succes it means that means the refresh token is still valid. Otherwise we return false so the device storage will be used.

The method checks if the user is logged in:
```
  Future<bool> isLoggedIn() async {
    final Either<LoginCredsResponseE, LoginResponseS> loginResponse =
        await loginApi.loginWithRefreshToken();
    if (loginApi.responseIsError(loginResponse)) {
      return false;
    }
    return true;
  }
```

Link to repository: 
- Adapter: https://github.com/ArieBisfki/hva_ivse1_project_mobile/blob/master/lib/feature/calender/recources/workoutLog_repository_adapter.dart

## Unit tests
In my opinion, writing unit tests for flutter isn't best practice. I would prefer to do integration testing, but unfortunately i couldn't make time for it since it would be an entire new learning curve.

To avoid having empty hands i created a unit tests that tests the validity and workings of the routing in the app. This piece of code mocks an observer and call runApp on the widget i want to start. With the keys inserted in the widgets i can find certain tiles or buttons so i can test them. After i mock a tap to a new page i check if the push to a new page actually appeared.

```
  testWidgets('navigation should work', (WidgetTester tester) async {
    final mockObserver = TestObserver();
    await tester.pumpWidget(
      MaterialApp(
        home: Calendar(
          loggedIn: false,
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.byType(WorkoutLogsOverview), findsOneWidget);
    await tester.tap(find.byType(WorkoutLogsOverview));
    await tester.pumpAndSettle();

    /// Verify that a push event happened
    verify(mockObserver.didPush(
        MaterialPageRoute<dynamic>(
            builder: (_) => WorkoutPage(
                  workoutLog: WorkoutLog(exerciseLogs: [], id: 0, date: ""),
                )),
        any));

    expect(find.byType(WorkoutPage), findsOneWidget);
  });
```