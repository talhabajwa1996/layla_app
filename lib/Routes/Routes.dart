import 'package:flutter/material.dart';
import 'package:layla_app_dev/UI/AuthUI/AuthUI.dart';
import 'package:layla_app_dev/UI/HomeUI/HomeUI.dart';
import 'package:layla_app_dev/UI/SplashUI/SplashUI.dart';
import 'package:page_transition/page_transition.dart';
import '../Utils/Constants/RouteConstants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteConstants.initialRoute:
        return PageTransition(
          child: const SplashScreenUI(),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.auth:
        return PageTransition(
          child: const AuthUI(),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.home:
        return PageTransition(
          child: const HomeUI(),
          type: PageTransitionType.rightToLeft,
        );
      default:
      // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}