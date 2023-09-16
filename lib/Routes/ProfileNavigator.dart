import 'package:flutter/material.dart';
import 'package:layla_app_dev/UI/AuthUI/ForgetPasswordUI.dart';
import '../UI/AuthUI/AuthUI.dart';
import '../Utils/Constants/RouteConstants.dart';

class ProfileNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const ProfileNavigator(this.navigatorKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: RouteConstants.initialRoute,
      onGenerateRoute: (RouteSettings settings) {
        var args = settings.arguments as dynamic;
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case RouteConstants.initialRoute:
                  return const AuthUI();
                case RouteConstants.forgetPassword:
                  return const ForgetPasswordUI();
                default:
                  return _errorRoute();
              }
            });
      },
    );
  }

  Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  }
}
