import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Controllers/CheckoutController/CheckoutController.dart';
import 'package:layla_app_dev/Models/CheckoutModels/CreateCheckoutRequestModel.dart';
import 'package:layla_app_dev/Models/CheckoutModels/CreateCheckoutResponseModel.dart';
import 'package:layla_app_dev/Services/ShopifyServices/Queries/createCheckout.dart';
import 'package:provider/provider.dart';
import '../API/ServerResponse.dart';
import '../API/api.dart';

class CheckoutService {
  Future<ServerResponse<CreateCheckoutResponseModel>> createCheckout(
      BuildContext context,
      List<LineItems> lineItems,
      String address1,
      String city,
      String province,
      String country,
      String firstName,
      String lastName,
      String zipCode) async {
    try {
      Provider.of<CheckoutController>(context, listen: false)
          .setIsCreatingCheckout(true);
      CreateCheckoutRequestModel _requestVariables = CreateCheckoutRequestModel(
          lineItems: lineItems,
          shippingAddress: ShippingAddress(
              address1: address1,
              city: city,
              country: country,
              firstName: firstName,
              lastName: lastName,
              province: province,
              zip: zipCode));
      Map<String, dynamic> response = await GraphqlApi.mutation(
          createCheckoutMutation, _requestVariables.toJson());
      CreateCheckoutResponseModel responseModel =
          CreateCheckoutResponseModel.fromJson(response);
      if (responseModel.checkoutCreate != null) {
        if (responseModel.checkoutCreate!.checkoutUserErrors!.isNotEmpty) {
          Provider.of<CheckoutController>(context, listen: false)
              .setIsCreatingCheckout(false);
          return ServerResponse.error(
              responseModel.checkoutCreate!.checkoutUserErrors!.first.message);
        } else {
          Provider.of<CheckoutController>(context, listen: false)
              .setIsCreatingCheckout(false);
          Provider.of<CheckoutController>(context, listen: false)
              .setCreateCheckoutResponse(responseModel);
          return ServerResponse.completed(responseModel);
        }
      } else {
        Provider.of<CheckoutController>(context, listen: false)
            .setIsCreatingCheckout(false);
        return ServerResponse.error('An Unexpected Error Occured');
      }
    } on Exception catch (e) {
      Provider.of<CheckoutController>(context, listen: false)
          .setIsCreatingCheckout(false);
      return ServerResponse.error(e.toString());
    }
  }
}
