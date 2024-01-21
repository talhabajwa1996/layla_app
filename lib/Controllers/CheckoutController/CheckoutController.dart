import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Models/CheckoutModels/CreateCheckoutResponseModel.dart';

class CheckoutController extends ChangeNotifier {
  CreateCheckoutResponseModel? _createCheckoutResponse;
  bool isCreatingCheckout = false;

  CreateCheckoutResponseModel? get createCheckoutResponse =>
      _createCheckoutResponse;

  void setCreateCheckoutResponse(CreateCheckoutResponseModel responseModel) {
    _createCheckoutResponse = responseModel;
    notifyListeners();
  }

  void setIsCreatingCheckout(bool value){
    isCreatingCheckout = value;
    notifyListeners();
  }
}