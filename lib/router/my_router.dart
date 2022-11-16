import 'package:flutter/material.dart';
import 'package:sample_project/router/route_animations.dart';
import 'package:sample_project/router/route_to.dart';
import 'package:sample_project/views/home/home_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == RouteTo.home.name) {
      return RouteAnimations.createRouteLeftToRight(
          const HomeScreen(), settings);
    }
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      ),
    );
  }
}
