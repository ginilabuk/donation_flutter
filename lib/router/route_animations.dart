import 'package:flutter/material.dart';

class RouteAnimations {
  static Route createRouteRotate(toRoute, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          toRoute,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
        ),

        child: child,
        // ),
      ),
    );
  }

  static Route createRouteFade(toRoute, [RouteSettings? settings]) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          toRoute,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  static Route createRouteLeftToRight(toRoute, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => toRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route createRouteBottomToTop(toRoute, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          toRoute,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          Align(
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      ),
    );
  }
}
