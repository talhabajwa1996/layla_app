import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Controllers/CheckoutController/CheckoutController.dart';
import 'package:layla_app_dev/Models/CheckoutModels/CompleteCheckoutResponseModel.dart';
import 'package:layla_app_dev/Models/CheckoutModels/CreateCheckoutRequestModel.dart';
import 'package:layla_app_dev/Models/CheckoutModels/CreateCheckoutResponseModel.dart';
import 'package:layla_app_dev/Services/ShopifyServices/Queries/createCheckout.dart';
import 'package:provider/provider.dart';
import '../../Models/CheckoutModels/CompleteCheckoutRequestModel.dart';
import '../API/ServerResponse.dart';
import '../API/api.dart';
import '../API/app_exceptions.dart';
import '../API/rest_api.dart';

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

  Future<ServerResponse<CompleteCheckoutResponseModel>> completeCheckout(
      BuildContext context, CompleteCheckoutRequestModel requestModel) async {
    try {
      Map<String, dynamic> response =
          await Api.postRequestData("/create/order", requestModel.toJson())
              as Map<String, dynamic>;
      CompleteCheckoutResponseModel responseModel =
          CompleteCheckoutResponseModel.fromJson(response);
      return ServerResponse.completed(responseModel);
    } on BadRequestException {
      return ServerResponse.error('Bad Request Exception');
    } on UnauthorisedException {
      return ServerResponse.error('The User is Un-authorized');
    } on RequestNotFoundException {
      return ServerResponse.error('Request Not Found');
    } on UnautorizationException {
      return ServerResponse.error('The User is Un-authorized');
    } on InternalServerException {
      return ServerResponse.error('Internal Server Error');
    } on ServerNotFoundException {
      return ServerResponse.error('Server Not Available');
    } on FetchDataException {
      return ServerResponse.error('An Error occurred while Fetching the Data');
    } catch (e) {
      return ServerResponse.error(e.toString());
    }
  }
}
