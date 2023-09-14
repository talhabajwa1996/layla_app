import 'package:flutter/material.dart';

class BottomBarController extends ChangeNotifier {
  TabController? _bottomNavigationBarController;
  final List<GlobalKey<NavigatorState>> bottomBarNavigationKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  TabController get tabController => _bottomNavigationBarController!;

  set initController(TabController controller) {
    _bottomNavigationBarController = controller;
  }

  disposeController() {
    _bottomNavigationBarController!.dispose();
  }

  moveToIndex(int index) {
    _bottomNavigationBarController!.animateTo(index);
    notifyListeners();
  }

}
