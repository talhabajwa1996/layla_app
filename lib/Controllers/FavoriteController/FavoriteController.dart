import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Models/ProductModels/favoriteProductIdsModel.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:layla_app_dev/Utils/Constants/KeysConstants.dart';
import 'package:shopify_flutter/models/src/product/product.dart';

import '../../Widgets/Notifiers/Toast.dart';

class FavoriteController extends ChangeNotifier {
  List<String> favoriteItems = [];
  List<Product>? productsList = [];

  initializeFavoriteController() async {
    try {
      var favorites = FavoriteProductIdsModel.fromJson(
          jsonDecode((await SharedPreferencesService().getString(KeysConstants.favoriteItemsList))!));
      if (favorites.productIds!.isNotEmpty) {
        for (var f in favorites.productIds!) {
          setItemFavorite(f, fromButton: false);
        }
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }

  setItemFavorite(String productId, {bool fromButton = true}) {
    if (favoriteItems.contains(productId)) {
      favoriteItems.remove(productId);
      productsList?.removeWhere((element) => element.id == productId);
      if (fromButton) {
        showToast("Removed from favorite");
      }
    } else {
      favoriteItems.add(productId);
      if(fromButton){
        showToast("Added to favorite");
      }
    }
    addListToLocalStorage();
    notifyListeners();
  }

  addListToLocalStorage() async {
    await SharedPreferencesService()
        .setJsonString(KeysConstants.favoriteItemsList, FavoriteProductIdsModel(productIds: favoriteItems).toJson());
    notifyListeners();
  }

  fetchFavoriteProducts(value) {
    productsList = value;
    notifyListeners();
  }
}
