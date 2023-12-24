import 'package:flutter/material.dart';
import 'package:layla_app_dev/UI/AppTrackingUI/AppTrackingUI.dart';
import 'package:layla_app_dev/UI/AuthUI/AuthUI.dart';
import 'package:layla_app_dev/UI/AuthUI/ForgetPasswordUI.dart';
import 'package:layla_app_dev/UI/BlogsUI/articlesUI.dart';
import 'package:layla_app_dev/UI/HomeUI/HomeUI.dart';
import 'package:layla_app_dev/UI/MenuUI/subCategoriesUI.dart';
import 'package:layla_app_dev/UI/ProductUI/productUI.dart';
import 'package:layla_app_dev/UI/SelectLangAndCurrencyUI/SelectLangAndCurrencyUI.dart';
import 'package:layla_app_dev/UI/SettingsUI/settingsUI.dart';
import 'package:layla_app_dev/UI/SplashUI/SplashUI.dart';
import 'package:page_transition/page_transition.dart';
import '../Utils/Constants/RouteConstants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
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
      case RouteConstants.forgetPassword:
        return PageTransition(
          child: const ForgetPasswordUI(),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.selectLanguage:
        return PageTransition(
          child: SelectLangAndCurrencyUI(),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.appTracking:
        return PageTransition(
          child: AppTrackingUI(),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.home:
        return PageTransition(
          child:  HomeUI(),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.settings:
        return PageTransition(
          child: const SettingsUI(),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.subCategories:
        return PageTransition(
          child: SubCategoriesUI(args: args),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.products:
        return PageTransition(
          child: ProductUI(args: args),
          type: PageTransitionType.rightToLeft,
        );
      case RouteConstants.articles:
        return PageTransition(
          child: ArticlesUI(args: args),
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
