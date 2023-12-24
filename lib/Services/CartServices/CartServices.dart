import 'package:flutter/material.dart';
import 'package:layla_app_dev/Controllers/CartControllers/CartController.dart';
import 'package:layla_app_dev/Models/CartModels/AddItemToCartRequestModel.dart';
import 'package:layla_app_dev/Models/CartModels/AddItemToCartResponseModel.dart';
import 'package:layla_app_dev/Models/CartModels/CreateCartAndAddItemRequestModel.dart';
import 'package:layla_app_dev/Models/CartModels/CreateCartAndAddItemResponseModel.dart';
import 'package:layla_app_dev/Models/CartModels/RetrieveCartRequestModel.dart';
import 'package:layla_app_dev/Models/CartModels/RetrieveCartResponseModel.dart';
import 'package:layla_app_dev/Models/CartModels/UpdateCartLinesRequestModel.dart';
import 'package:layla_app_dev/Models/CartModels/UpdateCartLinesResponseModel.dart';
import 'package:layla_app_dev/Services/API/QueriesAndMutations/RetrieveCartQuery.dart';
import 'package:layla_app_dev/Services/API/QueriesAndMutations/UpdateCartLineMutation.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:provider/provider.dart';
import '../../Utils/Globals.dart';
import '../API/QueriesAndMutations/AddItemToCartMutation.dart';
import '../API/QueriesAndMutations/CreateCartAndAddItemMutation.dart';
import '../API/ServerResponse.dart';
import '../API/api.dart';

class CartServices {
  Future<ServerResponse<CreateCartAndAddItemResponseModel>>
      createCartAndAddItem(BuildContext context, String merchandiseId) async {
    try {
      CreateCartAndAddItemRequestModel _requestVariables =
          CreateCartAndAddItemRequestModel(
              merchandiseId: merchandiseId, quantity: 1);
      Map<String, dynamic> response = await GraphqlApi.mutation(
          createCardAndAddItemMutation, _requestVariables.toJson());
      CreateCartAndAddItemResponseModel responseModel =
          CreateCartAndAddItemResponseModel.fromJson(response);
      if (responseModel.cartCreate != null) {
        await SharedPreferencesService()
            .setString('cart_id', responseModel.cartCreate!.cart!.id);
        await SharedPreferencesService().setInt('cart_items_count', 1);
        cartId = responseModel.cartCreate!.cart!.id;
        if (responseModel.cartCreate!.userErrors!.isNotEmpty) {
          return ServerResponse.error(
              responseModel.cartCreate!.userErrors!.first.message);
        } else {
          await retrieveCart(context);
          return ServerResponse.completed(responseModel);
        }
      } else {
        return ServerResponse.error(
            responseModel.cartCreate!.userErrors!.first.message);
      }
    } on Exception catch (e) {
      return ServerResponse.error(e.toString());
    }
  }

  Future<ServerResponse<AddItemToCartResponseModel>> addItemToCart(
      BuildContext context, String merchandiseId) async {
    try {
      AddItemToCartRequestModel _requestVariables = AddItemToCartRequestModel(
          cartId: cartId,
          lines: [
            LinesAddItemToCart(merchandiseId: merchandiseId, quantity: 1)
          ]);
      Map<String, dynamic> response = await GraphqlApi.mutation(
          addItemToCartMutation, _requestVariables.toJson());
      AddItemToCartResponseModel responseModel =
          AddItemToCartResponseModel.fromJson(response);
      if (responseModel.cartLinesAdd != null) {
        int? cartItemsPrevious =
            await SharedPreferencesService().getInt('cart_items_count');
        await SharedPreferencesService().setInt('cart_items',
            cartItemsPrevious != null ? cartItemsPrevious + 1 : 1);
        if (responseModel.cartLinesAdd!.userErrors!.isNotEmpty) {
          return ServerResponse.error(
              responseModel.cartLinesAdd!.userErrors!.first.message);
        } else {
          await retrieveCart(context);
          return ServerResponse.completed(responseModel);
        }
      } else {
        return ServerResponse.error(
            responseModel.cartLinesAdd!.userErrors!.first.message);
      }
    } on Exception catch (e) {
      return ServerResponse.error(e.toString());
    }
  }

  Future<ServerResponse<UpdateCartLinesResponseModel>> updateCartLine(
      BuildContext context,
      String merchandiseId,
      String lineId,
      int quantity) async {
    try {
      showDialog(
          context: context,
          barrierColor: Colors.white.withOpacity(0.6),
          builder: (context) => const AppLoader(size: 30));
      UpdateCartLinesRequestModel _requestVariables =
          UpdateCartLinesRequestModel(
              cartId: cartId,
              lines: [LinesUpdate(id: lineId, quantity: quantity)]);
      Map<String, dynamic> response = await GraphqlApi.mutation(
          updateCartLineMutation, _requestVariables.toJson());
      UpdateCartLinesResponseModel responseModel =
          UpdateCartLinesResponseModel.fromJson(response);
      if (responseModel.cartLinesUpdate!.userErrors!.isNotEmpty) {
        print(responseModel.cartLinesUpdate!.userErrors!.first
            .toJson()
            .toString());
        Navigator.pop(context);
        return ServerResponse.error(
            responseModel.cartLinesUpdate!.userErrors!.first.message);
      } else {
        await retrieveCart(context);

        Navigator.pop(context);
        return ServerResponse.completed(responseModel);
      }
    } on Exception catch (e) {
      Navigator.pop(context);
      return ServerResponse.error(e.toString());
    }
  }

  Future<ServerResponse<RetrieveCartResponseModel>> retrieveCart(
      BuildContext context) async {
    try {
      RetrieveCartRequestModel _requestVariables =
          RetrieveCartRequestModel(cartId: cartId);
      Map<String, dynamic> response = await GraphqlApi.query(retrieveCartQuery,
          variables: _requestVariables.toJson());
      RetrieveCartResponseModel responseModel =
          RetrieveCartResponseModel.fromJson(response);
      Provider.of<CartController>(context, listen: false)
          .setRetrieveCartResponse(responseModel);
      return ServerResponse.completed(responseModel);
    } on Exception catch (e) {
      return ServerResponse.error(e.toString());
    }
  }
}
