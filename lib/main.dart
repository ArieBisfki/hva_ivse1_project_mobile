import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/bloc/calendar_bloc.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_db_adapter.dart';

import 'common/route/route_generator.dart';
import 'common/route/routes.dart';
import 'feature/calender/recources/calendar_repository_device.dart';

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
        RepositoryProvider<CalendarRepositoryDevice>(
          create: (BuildContext context) => CalendarRepositoryDevice(
            dbAdapter: CalendarDbAdapter(),
          ),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CalendarBloc>(
            create: (BuildContext context) => CalendarBloc(
                calendarRepository:
                    RepositoryProvider.of<CalendarRepositoryDevice>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Hooray App',
          //navigatorObservers: [RouteObserver<PageRoute>()],
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: Routes.landing,
        ),
      ),
    );
  }
}
