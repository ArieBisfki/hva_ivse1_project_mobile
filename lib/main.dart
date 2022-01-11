import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/bloc/calendar_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/recources/workoutLog_db_adapter.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_adapter.dart';
import 'package:ivse1_gymlife/feature/workout/resources/workout_repository.dart';

import 'common/route/route_generator.dart';
import 'common/route/routes.dart';
import 'feature/calender/recources/workoutLog_repository_device.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WorkoutLogRepositoryDevice>(
          create: (BuildContext context) => WorkoutLogRepositoryDevice(
            dbAdapter: WorkoutLogDbAdapter(),
          ),
          lazy: true,
        ),
        RepositoryProvider<ExerciseLogRepository>(
          create: (BuildContext context) => ExerciseLogRepository(
            dbAdapter: ExerciseLogDbAdapter(),
          ),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CalendarBloc>(
            create: (BuildContext context) => CalendarBloc(
                calendarRepository:
                    RepositoryProvider.of<WorkoutLogRepositoryDevice>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'GymLife',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: Routes.login,
        ),
      ),
    );
  }
}
