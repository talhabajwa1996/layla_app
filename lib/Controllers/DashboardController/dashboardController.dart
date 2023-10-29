import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier{

  int selectedTabIndex = 0;

  set setTabIndex(value){
    selectedTabIndex = value;
    notifyListeners();
  }

}