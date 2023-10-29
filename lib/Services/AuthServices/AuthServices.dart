import 'package:flutter/cupertino.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/Models/AuthModels/CreateAccountRequestModel.dart';
import 'package:layla_app_dev/Models/AuthModels/CreateAccountResponseModel.dart';
import 'package:layla_app_dev/Models/AuthModels/LoginRequestModel.dart';
import 'package:layla_app_dev/Models/AuthModels/LoginResponseModel.dart';
import 'package:layla_app_dev/Models/AuthModels/SendPasswordResetRequestModel.dart';
import 'package:layla_app_dev/Models/AuthModels/SendPasswordResetResponseModel.dart';
import 'package:layla_app_dev/Services/API/Mutations/CreateAccountMutation.dart';
import 'package:layla_app_dev/Services/API/Mutations/GetUserDetailMutation.dart';
import 'package:layla_app_dev/Services/API/Mutations/LoginMutation.dart';
import 'package:layla_app_dev/Services/API/Mutations/SendPasswordResetMutation.dart';
import 'package:layla_app_dev/Services/API/api.dart';
import 'package:layla_app_dev/Services/API/ServerResponse.dart';
import 'package:layla_app_dev/Utils/Globals.dart';
import 'package:provider/provider.dart';
import 'package:shopify_flutter/shopify/src/shopify_auth.dart';

// class AuthServices {
//   Future<ServerResponse<LoginResponseModel>> signInWithEmailAndPassword(BuildContext context,
//       {required String email, required String password}) async {
//     var controller = Provider.of<AuthController>(context, listen: false);
//     try {
//       controller.setLoginLoading(true);
//       LoginRequestModel _requestVariables = LoginRequestModel(
//         email: email,
//         password: password,
//       );
//       Map<String, dynamic> response = await GraphqlApi.mutation(loginMutation, _requestVariables.toJson());
//       print("Auth Response:: $response");
//       LoginResponseModel responseModel = LoginResponseModel.fromJson(response);
//       controller.setLoginLoading(false);
//       if (responseModel.customerAccessTokenCreate!.customerAccessToken != null) {
//         customerAccessToken = responseModel.customerAccessTokenCreate!.customerAccessToken!.accessToken;
//
//         Map<String, dynamic> response2 = await GraphqlApi.query(getUserDetailsMutation);
//         print("User Details Response:: $response2");
//         return ServerResponse.completed(responseModel);
//       } else {
//         return ServerResponse.error(responseModel.customerAccessTokenCreate!.customerUserErrors!.first.message);
//       }
//     } on Exception catch (e) {
//       controller.setLoginLoading(false);
//       return ServerResponse.error(e.toString());
//     }
//   }
//
//   Future<ServerResponse<CreateAccountResponseModel>> createUserWithEmailAndPassword(
//       BuildContext context, String firstName, String lastName, String email, String password) async {
//     var controller = Provider.of<AuthController>(context, listen: false);
//     try {
//       controller.setSignupLoading(true);
//       CreateAccountRequestModel _requestVariables = CreateAccountRequestModel(
//           input: Input(email: email, password: password, lastName: lastName, firstName: firstName, acceptsMarketing: true));
//       Map<String, dynamic> response = await GraphqlApi.mutation(createAccountMutation, _requestVariables.toJson());
//       CreateAccountResponseModel responseModel = CreateAccountResponseModel.fromJson(response);
//       controller.setSignupLoading(false);
//       if (responseModel.customerCreate!.customer != null) {
//         return ServerResponse.completed(responseModel);
//       } else {
//         return ServerResponse.error(responseModel.customerCreate!.customerUserErrors!.first.message);
//       }
//     } on Exception catch (e) {
//       controller.setSignupLoading(false);
//       return ServerResponse.error(e.toString());
//     }
//   }
//
//   Future<ServerResponse<SendPasswordResetResponseModel>> sendPasswordResetEmail(BuildContext context, String email) async {
//     var controller = Provider.of<AuthController>(context, listen: false);
//     try {
//       controller.setForgetPasswordLoading(true);
//       SendPasswordResetRequestModel _requestVariables = SendPasswordResetRequestModel(email: email);
//       Map<String, dynamic> response = await GraphqlApi.mutation(sendPasswordResetMutation, _requestVariables.toJson());
//       SendPasswordResetResponseModel responseModel = SendPasswordResetResponseModel.fromJson(response);
//       controller.setForgetPasswordLoading(false);
//       if (responseModel.customerRecover!.customerUserErrors!.isEmpty && responseModel.customerRecover!.userErrors!.isEmpty) {
//         return ServerResponse.completed(responseModel);
//       } else {
//         return ServerResponse.error(responseModel.customerRecover!.customerUserErrors!.first.message);
//       }
//     } on Exception catch (e) {
//       controller.setForgetPasswordLoading(false);
//       return ServerResponse.error(e.toString());
//     }
//   }
//
//
//   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
// }
