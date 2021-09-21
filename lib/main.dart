import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: 'Hooray App',
      //theme: basicTheme,
      //navigatorObservers: [RouteObserver<PageRoute>()],
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: Routes.landing,
    );
  }
}
