import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Models/ReturnModels/returnableFulfillmentResponseModel.dart';
import 'dart:io';

import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';

class ExchangeAndReturnController extends ChangeNotifier {
  ReturnableFulfillments? _returnableFulfillments;
  ReturnableFulfillments? get returnableFulfillments => _returnableFulfillments;
  List<File> imageFiles = [];
  double animatedContainerHeight = 0;

  set setReturnableItems(ReturnableFulfillments reponse) {
    _returnableFulfillments = reponse;
    notifyListeners();
  }


  PageController pageController = PageController(initialPage: 0);
  double progressValue = 0.25;
  String? returnReason = "";
  String? resolution = "";
  String? shipping = "";

  moveToNextPage() {
    pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
    progressValue += 0.25;
    notifyListeners();
  }

  moveToPreviousPage() {
    pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
    progressValue -= 0.25;
    notifyListeners();
  }

  setReason(value) {
    returnReason = value;
    notifyListeners();
  }

  addImage(File value){
    if(imageFiles.length <= 5){
      imageFiles.add(value);
    }else{
      showToast("Please select max 6 images");
    }

    notifyListeners();
  }

  removeImage(index){
    imageFiles.removeAt(index);
    notifyListeners();
  }

  setContainerHeight(value){
    animatedContainerHeight = value;
    notifyListeners();
  }

  setResolution(value) {
    resolution = value;
    notifyListeners();
  }

  setShipping(value) {
    shipping = value;
    notifyListeners();
  }

  resetProvider() {
    imageFiles.clear();
    progressValue = 0.25;
    returnReason = "";
    resolution = "";
    shipping = "";
    notifyListeners();
  }
}
