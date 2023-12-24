import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Models/CartModels/RetrieveCartResponseModel.dart';

class CartController extends ChangeNotifier {
  RetrieveCartResponseModel? _retrieveCartResponse;

  RetrieveCartResponseModel? get retrieveCartResponse => _retrieveCartResponse;

  void setRetrieveCartResponse(RetrieveCartResponseModel responseModel) {
    _retrieveCartResponse = responseModel;
    notifyListeners();
  }
}
