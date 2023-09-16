import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Models/MenuCollectionsModel/MenuCollectionsResponseModel.dart';

class MenuCollectionsController extends ChangeNotifier {
  MenuCollectionsResponseModel? _menuCollectionsResponse;

  MenuCollectionsResponseModel? get menuCollectionsResponse =>
      _menuCollectionsResponse;

  void setMenuCollectionsResponse(MenuCollectionsResponseModel responseModel) {
    _menuCollectionsResponse = responseModel;
    notifyListeners();
  }
}
