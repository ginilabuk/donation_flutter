import 'package:donation_flutter/views/settings/settings_screen.dart';
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
    if (settings.name == RouteTo.settings.name) {
      return RouteAnimations.createRouteLeftToRight(
          const SettingsScreen(), settings);
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
