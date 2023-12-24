import 'package:flutter/material.dart';
import 'package:layla_app_dev/Controllers/CartControllers/CartController.dart';
import 'package:layla_app_dev/Models/CartModels/AddItemToCartRequestModel.dart';
import 'package:layla_app_dev/Models/CartModels/AddItemToCartResponseModel.dart';
import 'package:layla_app_dev/Models/CartModels/CreateCartAndAddItemRequestModel.dart';
import 'package:layla_app_dev/Models/CartModels/CreateCartAndAddItemResponseModel.dart';
import 'package:layla_app_dev/Models/CartModels/RetrieveCartRequestModel.dart';
import 'package:layla_app_dev/Models/CartModels/RetrieveCartResponseModel.dart';
import 'package:layla_app_dev/Services/API/QueriesAndMutations/RetrieveCartQuery.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:provider/provider.dart';
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
      String? cartId = await SharedPreferencesService().getString('cart_id');
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

  Future<ServerResponse<RetrieveCartResponseModel>> retrieveCart(
      BuildContext context) async {
    try {
      String? cartId = await SharedPreferencesService().getString('cart_id');
      RetrieveCartRequestModel _requestVariables =
          RetrieveCartRequestModel(cartId: cartId);
      Map<String, dynamic> response = await GraphqlApi.query(retrieveCartQuery,
          variables: _requestVariables.toJson());
      print("RESPONSE LENGTH:    +++++++   " + response['cart']['lines']['nodes'].length.toString());
      RetrieveCartResponseModel responseModel =
          RetrieveCartResponseModel.fromJson(response);
      print("MODEL ITEMS:      +++++++  " +
          responseModel.cart!.lines!.nodes!.length.toString());
      Provider.of<CartController>(context, listen: false)
          .setRetrieveCartResponse(responseModel);
      print("ITEMS:        +++++++++   " +
          Provider.of<CartController>(context, listen: false)
              .retrieveCartResponse!
              .cart!
              .lines!
              .nodes!
              .length
              .toString());
      return ServerResponse.completed(responseModel);
    } on Exception catch (e) {
      return ServerResponse.error(e.toString());
    }
  }
}
