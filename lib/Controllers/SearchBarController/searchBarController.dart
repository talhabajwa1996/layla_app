import 'package:flutter/cupertino.dart';

class SearchBarController extends ChangeNotifier{
  TextEditingController searchController = TextEditingController();
  String lastWords = '';
  String lastStatus = '';
  bool isSearching = false;

  set setLastWords(value){
    lastWords = value;
    notifyListeners();
  }

  set setLastStatus(value){
    lastStatus = value;
    notifyListeners();
  }

  set setSearching(value){
    isSearching = value;
    notifyListeners();
  }


  resetProvider(){
    lastWords = "";
    searchController.clear();
    notifyListeners();
  }

}