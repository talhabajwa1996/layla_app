import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Controllers/MenuCollectionsController/MenuCollectionsController.dart';
import 'package:layla_app_dev/Models/MenuCollectionsModel/MenuCollectionsResponseModel.dart';
import 'package:layla_app_dev/Services/API/Queries/GetMenuCollectionsAndSubcollectionsQuery.dart';
import 'package:layla_app_dev/Services/API/ServerResponse.dart';
import 'package:provider/provider.dart';
import '../API/api.dart';

class MenuCollectionsService {
  Future<ServerResponse<MenuCollectionsResponseModel>>
      getMenuCategoriesAndSubCategories(BuildContext context) async {
    var controller = Provider.of<MenuCollectionsController>(context, listen: false);
    try {
      Map<String, dynamic> response =
          await GraphqlApi.query(menuCollectionsAndSubCollectionsQuery);
      MenuCollectionsResponseModel responseModel = MenuCollectionsResponseModel.fromJson(response);
      if (responseModel.menu != null) {
        controller.setMenuCollectionsResponse(responseModel);
        return ServerResponse.completed(responseModel);
      } else {
        return ServerResponse.error('Error Fetching the Menu');
      }
    } on Exception catch (e) {
      return ServerResponse.error(e.toString());
    }
  }
}
