import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layla_app_dev/Models/ProductModels/VariantOptionModel.dart';
import '../../Models/ProductModels/ProductByCollectionModel.dart';

class FilteringController extends ChangeNotifier{
  var availableSizes = [];
  var availableColors = [];
  List<double> availablePrices = [];
  double minPrice = 0.0;
  double maxPrice = 0.0;
  var selectedSizes = [];
  var selectedColors = [];
  RangeValues values = RangeValues(0.0, 0.0);
  var filters = [];



  initializeFilters(Products products){
    var productslist = products.edges;
    for(var p in productslist!){
      var size = p.node?.options?.where((element) => element.name!.toLowerCase() == "size").first.values;
      addSizes(size);

      var color = p.node?.options?.where((element) => element.name!.toLowerCase() == "color").first.values;
      addColors(color);


      var price = double.parse(p.node!.priceRange!.minVariantPrice!.amount!);
      addPrices(price);

    }
    print("AvailableSizes:: ${availableSizes}");
    print("AvailableColors:: ${availableColors}");
    getMinAndMaxNumber(availablePrices);
    initSliderValues();
    notifyListeners();
  }

  addSizes(List<String>? value){
    if(value != null){
      for(var v in value){
        if(!availableSizes.contains(v)){
          availableSizes.add(v);
        }
      }
    }
    notifyListeners();
  }

  addColors(List<String>? value){
    if(value != null){
      for(var v in value){
        if(!availableColors.contains(v)){
          availableColors.add(v);
        }
      }
    }
    notifyListeners();
  }

  addPrices(double value){
    if(!availablePrices.contains(value)){
      availablePrices.add(value);
    }
    notifyListeners();
  }

  getMinAndMaxNumber(List<double> prices){
    minPrice = prices.reduce((a, b) => a < b ? a : b);
    maxPrice = prices.reduce((a, b) => a > b ? a : b);

    print("Price Range: $minPrice - $maxPrice");
    notifyListeners();
  }

  selectSizes(value){
    if(selectedSizes.contains(value)){
      selectedSizes.remove(value);
    }else{
      selectedSizes.add(value);
    }
    notifyListeners();
  }

  selectColors(value){
    if(selectedColors.contains(value)){
      selectedColors.remove(value);
    }else{
      selectedColors.add(value);
    }
    notifyListeners();
  }

  initSliderValues(){
    values = RangeValues(minPrice, maxPrice);
    return values;
  }

  setRangeValues(value){
    values = value;
    notifyListeners();
  }

  checkTitleInProvider(String title) {
    bool isAvailable = false;
    if (selectedSizes.contains(title) || selectedColors.contains(title)) {
      return isAvailable = true;
    } else {
      return isAvailable;
    }
  }

  setFiltersMap(){
    filters.clear();
    for(var c in selectedColors){
      filters.add(VariantOptionModel(variantOption: VariantOption(name: "Color", value: c)).toJson());
    }
    for(var s in selectedSizes){
      filters.add(VariantOptionModel(variantOption: VariantOption(name: "Size", value: s)).toJson());
    }
    if(values.start != 0.0 && values.end != 0.0){
      filters.add({"price": {"min": values.start, "max": values.end} });
    }
    // if(filters.any((element) => element['variantOption']['value'] == value.variantOption?.value)){
    //   print("filters already in map");
    // }else{
    //   filters.add(value.toJson());
    // }
    notifyListeners();
  }

  resetProvider(){
    pageIndex = 0;
    availableSizes = [];
    availableColors = [];
    availablePrices = [];
    minPrice = 0.0;
    maxPrice = 0.0;
    selectedSizes = [];
    selectedColors = [];
    values = RangeValues(0.0, 0.0);
    filters.clear();
    print("Filters Reset");
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////

  int pageIndex = 0;
  PageController controller = PageController();

  setPageIndex(int value){
    pageIndex = value;
    controller.jumpToPage(pageIndex);
    notifyListeners();
  }

}