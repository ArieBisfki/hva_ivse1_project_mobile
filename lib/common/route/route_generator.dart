import 'package:flutter/material.dart';
import 'package:ivse1_gymlife/common/route/routes.dart';
import 'package:ivse1_gymlife/feature/calender/ui/calendar_overview.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case Routes.landing:
        return MaterialPageRoute<dynamic>(builder: (_) => Calendar());
      default:
        return MaterialPageRoute<dynamic>(builder: (_) => Calendar());
    }
  }
}
