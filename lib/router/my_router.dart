import 'package:donation_flutter/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:donation_flutter/router/route_animations.dart';
import 'package:donation_flutter/router/route_to.dart';
import 'package:donation_flutter/views/home/home_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == RouteTo.home.name) {
      return RouteAnimations.createRouteLeftToRight(
          const HomeScreen(), settings);
    }
    if (settings.name == RouteTo.splash.name) {
      return RouteAnimations.createRouteLeftToRight(
          const SplashView(), settings);
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
