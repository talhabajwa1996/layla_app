import 'package:flutter/material.dart';
import 'package:layla_app_dev/Models/MenuCollectionsModel/MenuCollectionsResponseModel.dart';
import 'package:layla_app_dev/UI/MenuCategoriesUI/SubCategoriesUI.dart';
import '../UI/MenuCategoriesUI/MenuMainCategoriesUI.dart';
import '../Utils/Constants/RouteConstants.dart';

class MenuNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MenuNavigator(this.navigatorKey, {super.key});

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
                  return const MenuMainCategoriesUI();
                case RouteConstants.menuSubCategories:
                  return MenuSubCategoriesUI(args as List<SubCollectionItems>);
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
