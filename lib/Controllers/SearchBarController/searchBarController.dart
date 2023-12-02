import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopify_flutter/enums/src/sort_key_product.dart';
import 'package:shopify_flutter/models/src/product/product.dart';

import '../../Services/ShopifyServices/ShopifyServices.dart';

class SearchBarController extends ChangeNotifier{
  TextEditingController searchController = TextEditingController();
  String lastWords = '';
  String lastStatus = '';
  bool isSearching = false;
  bool isLoadingProducts = false;
  List<Product> searchedProducts = [];

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

  set setLoadingProducts(value){
    isLoadingProducts = value;
    notifyListeners();
  }

  setSearchedProductsList(value){
    searchedProducts = value;
    notifyListeners();
  }

  searchAndFetchProducts(){
    setLoadingProducts = true;
    var future = ShopifyService().shopifyStore.getAllProductsOnQuery(
        "", searchController.text.isEmpty ? "??"
        : searchController.text, sortKey: SortKeyProduct.BEST_SELLING);
    future.then((value) {
      print(value.toList());
      setSearchedProductsList(value.toList());
      setLoadingProducts = false;
    }, onError: (e) {
      setSearchedProductsList([]);
      setLoadingProducts = false;
    });

    notifyListeners();
  }


  resetProvider(){
    lastWords = "";
    searchController.clear();
    notifyListeners();
  }

}