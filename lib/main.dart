import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/bloc/calendar_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_api_provider.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_repository.dart';

import 'common/route/route_generator.dart';
import 'common/route/routes.dart';

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
        RepositoryProvider<CalendarApiProvider>(
          create: (BuildContext context) => CalendarApiProvider(),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CalendarBloc>(
            create: (BuildContext context) => CalendarBloc(
                calendarRepository:
                    RepositoryProvider.of<CalendarRepository>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Hooray App',
          //navigatorObservers: [RouteObserver<PageRoute>()],
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: Routes.workoutcategory,
        ),
      ),
    );
  }
}
