import 'package:donation_flutter/router/route_to.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/effects.dart';
import 'package:get_it/get_it.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  Future<void> bootstrap(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteTo.home.name, (route) => false);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bootstrap(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          Align(
            child: const Text("Donation Flutter")
                .animate()
                .fade()
                .scale(duration: const Duration(seconds: 1)),
            // child: Image.asset(
            //   "assets/images/logo.png",
            //   fit: BoxFit.scaleDown,
            // ).animate().fade().scale(duration: const Duration(seconds: 1)),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Copyright © 2022 \n All right reserved by Ginilab Ltd.",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
